server <- function(input, output) {
# Data
  data <- reactive({
    req(input$file)
    ext <- tools::file_ext(input$file$name)
    switch(ext,
      csv = vroom::vroom(input$file$datapath, delim = ","),
      tsv = vroom::vroom(input$file$datapath, delim = "\t"),
      validate("Invalid file; Please upload a .csv or .tsv file")
    )
  })
  output$preview <- renderTable({head(data())})
# Model
  status <- reactive({paste(input$outcome)})
  time <- reactive({paste(input$time)})
  covariates <- reactive({paste(input$covariates, collapse=" + ")})
# Download
  output$download <- downloadHandler(
    filename = function() {paste0(tools::file_path_sans_ext(input$file), ".tsv")},
    content = function(file) {vroom::vroom_write(data(), file)}
  )
# Report
  km_formulaText <- reactive({paste("Surv(",input$time, ",", input$outcome, ") ~ 1")})
  output$km_caption <- renderText({km_formulaText()})
  output$km <- renderPlot({plot(survfit(as.formula(km_formulaText()), data = data()), xlab = "Time",
                                ylab = "Overall survival probability", main = km_formulaText())})
  cox_formulaText <- reactive({paste("Surv(",input$time, ",", input$outcome, ") ~ ", covariates())})
  output$cox_caption <- renderText({cox_formulaText()})
  coxfit <- reactive({coxph(as.formula(cox_formulaText()), data=data())})
  new_df <- reactive({with(data(),
                           data.frame(sex = c(1, 2),
                                      age = rep(mean(age, na.rm = TRUE), 2),
                                      wt.loss = rep(mean(wt.loss, na.rm = TRUE), 2)
                           )
                     )})
  fit <- reactive({survfit(coxfit(), newdata = new_df())})
  output$cox <- renderPlot({ggsurvplot(fit(), conf.int = TRUE, palette = "Dark2", censor = FALSE,
                                       surv.median.line = "hv", data=data()) + ggtitle(cox_formulaText())})
  output$report <- downloadHandler(
    filename = function() {
      paste(tools::file_path_sans_ext(input$file), sep = ".", 
            switch(input$format, PDF = 'pdf', HTML = 'html', Word = 'docx')
      )
    },
    content = function(file) {
      src <- normalizePath('report.Rmd')
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report.Rmd', overwrite = TRUE)
      out <- render('report.Rmd', switch(input$format, PDF = pdf_document(), HTML = html_document(), Word = word_document()))
      file.rename(out, file)
    }
  )
}

# It is possible to communicate with .Rmd as follows,
#   content = function(file) {
#     tempReport <- file.path(tempdir(), "report.Rmd")
#     file.copy("report.Rmd", tempReport, overwrite = TRUE)
#     params <- list(data=data(),status=status(),time=time(),covariates=covariates())
#     rmarkdown::render(tempReport, output_file = file,
#        params = params,
#        envir = new.env(parent = globalenv())
#     )
#   }
# where the.Rmd contains header section:
# ---
# title: "Analysis report"
# output: pdf_document
# params:
#  data: NA
#  status: NA
#  time: NA
#  covariates: NA
# ---
# so we can use data <- with(params, data), etc.

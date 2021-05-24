server <- function(input, output) {
# Data
  data <- reactive({
    if(input$example) survival::lung else {
    req(input$file)
    ext <- tools::file_ext(input$file$name)
    switch(ext,
      csv = vroom::vroom(input$file$datapath, delim = ","),
      tsv = vroom::vroom(input$file$datapath, delim = "\t"),
      validate("Invalid file; Please upload a .csv or .tsv file")
    )}
  })
  output$preview <- renderTable({head(data())})
# Download
  output$download <- downloadHandler(
    filename = function() {paste(ifelse(input$example,"lung",tools::file_path_sans_ext(input$file)), sep=".",
                           switch(input$dataFormat, bz2="bz2",
                                                    csv="csv",
                                                    gz="gz",
                                                    tsv="tsv",
                                                    xz="xz"))},
    content = function(file) {vroom::vroom_write(data(), file)}
  )
# Model
  output$status <- renderUI({
     selectInput("status", "Status:", names(data()), selected="status")
  })
  output$time <- renderUI({
     selectInput("time", "Time:", names(data()), selected="time")
  })
  output$covariates <- renderUI({
     selectInput("covariates", "Covariates:", names(data()),
                 selected=c("sex", "age", "wt.loss"), multiple=TRUE)
  })
  output$strata <- renderUI({
     selectInput("strata", "Stratification variable:", names(data()),
                 selected="sex", multiple=TRUE)
  })
  status <- reactive({paste(input$status)})
  time <- reactive({paste(input$time)})
  covariates <- reactive({paste(input$covariates, collapse=" + ")})
  strata <- reactive({paste(input$strata)})
# Report
  km_formulaText <- reactive({paste("Surv(",input$time, ",", input$status, ") ~ 1")})
  output$km_caption <- renderText({km_formulaText()})
  output$km <- renderPlot({plot(survfit(as.formula(km_formulaText()), data = data()), xlab = "Time",
                                ylab = "Overall survival probability", main = km_formulaText())})
  km_formulaText_strata <- reactive({paste("Surv(",input$time, ",", input$status, ") ~ ", input$strata)})
  output$km_caption_strata <- renderText({km_formulaText_strata()})
  fit <- reactive({survfit(as.formula(km_formulaText_strata()), data = data())})
  output$km_strata <- renderPlot({ggsurvplot(fit(), data = data(), pval = TRUE, pval.method = TRUE)})
  cox_formulaText <- reactive({paste("Surv(",input$time, ",", input$status, ") ~ ", covariates())})
  output$cox_caption <- renderText({cox_formulaText()})
  coxfit <- reactive({coxph(as.formula(cox_formulaText()), data=data())})
  output$coxfit <- renderPrint({if(input$summary) summary(coxfit()) else print("Not selected")})
  new_df <- reactive({with(data(), {
                           grp <- unique(sort(data()[[strata()]]))
                           data.frame(distinct(data()[strata()]),
                                      as.data.frame(lapply(apply(data()[setdiff(names(data()),strata())],2,mean,na.rm=TRUE),rep,length(grp)))
                           )})
                     })
  fit <- reactive({survfit(coxfit(), newdata = new_df())})
  output$fit <- renderPrint({if (input$summary) summary(fit()) else print("Not selected")})
  output$cox <- renderPlot({ggsurvplot(fit(), conf.int = TRUE, palette = "Dark2", censor = FALSE,
                                       surv.median.line = "hv", data=data()) + ggtitle(cox_formulaText())})
  output$report <- downloadHandler(
    filename = function() {
      paste(tools::file_path_sans_ext(input$file), sep = ".", 
            switch(input$reportFormat, PDF = 'pdf', HTML = 'html', Word = 'docx')
      )
    },
    content = function(file) {
      src <- normalizePath('report.Rmd')
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report.Rmd', overwrite = TRUE)
      out <- render('report.Rmd', switch(input$reportFormat, PDF = pdf_document(), HTML = html_document(), Word = word_document()))
      file.rename(out, file)
    }
  )
}

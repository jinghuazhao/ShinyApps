server <- function(input, output) {
  data <- reactive({
    req(input$file)
    ext <- tools::file_ext(input$file$name)
    switch(ext,
      csv = vroom::vroom(input$file$datapath, delim = ","),
      tsv = vroom::vroom(input$file$datapath, delim = "\t"),
      validate("Invalid file; Please upload a .csv or .tsv file")
    )
  })
  library(survival)
  output$km <- renderPlot({plot(survfit(Surv(time, status) ~ 1, data = data()), xlab = "Days",  ylab = "Overall survival probability")})
  output$preview <- renderTable({
    head(data())
  })
  output$download <- downloadHandler(
    filename = function() {
      paste0(tools::file_path_sans_ext(input$file), ".tsv")
    },
    content = function(file) {
      vroom::vroom_write(data(), file)
    }
  )
  output$report <- downloadHandler(
    # For html output, change this to ".html"
    filename = function() {
      paste0(tools::file_path_sans_ext(input$file), ".pdf")
    },
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)

      # Set up parameters to pass to Rmd document
      params <- list(data=data())
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
         params = params,
         envir = new.env(parent = globalenv())
      )
    }
  )
}

source("R/init.R")

ui <- dashboardPage(
  title = "shinySurvival",
  dashboardHeader(
     title = tags$a(href='https://github.com/jinghuazhao/ShinyApps', target = '_blank',
                    tags$img(src=paste0("bees.svg"), height = "70%", width = "auto", align = "middle")
     ),
     dropdownMenu(type = "messages",
        tags$li(HTML('<li><a href="https://github.com/jinghuazhao/ShinyApps" target="_blank"><i class="fa fa-code-branch"></i><h4>GitHub</h4></a></li>')),
        tags$li(HTML('<li><a href="mailto:jinghuazhao@hotmail.com" target="_blank"><i class="fa fa-question"></i><h4>email</h4></a></li>'))
     )
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "landing", icon = icon("home")),
      menuItem("Data", tabName = "Data", icon = icon("upload")),
      menuItem("Download", tabName = "Download", icon = icon("download")),
      menuItem("Model", tabName = "Model", icon = icon("th")),
      menuItem("Report", tabName = "Report", icon = icon("book-open"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "landing",
         div(class = "jumbotron", HTML("<center><h1>Shiny for Survival analysis</h1></center>")),
         fluidRow(div(class = "col-sm-12",
                      div(class = "box box-primary", style = "padding-right: 5%; padding-left: 5%; font-size:100%", NULL,
                          div(class = "box-body", shiny::includeMarkdown("README.md"))
                      )
                 )
         )
      ),
      tabItem(tabName = "Data",
        h2("Upload a csv or tsv file"),
        fluidRow(
          fileInput("file", NULL, accept = c(".csv", ".tsv")),
          tableOutput("files"),
          helpText("The first few lines are given as follows,"),
          tableOutput("preview")
        )
      ),
      tabItem(tabName = "Download",
        h2("Download a specific version of the data"),
        helpText("The data could be in a variety of formats. The bz2 format can be viewed with bzcat, gz format with zcat, and xz with xz -dc."),
        radioButtons('dataFormat', 'Data format:', c('bz2', 'csv', 'gz', 'tsv', 'xz'), inline = TRUE),
        downloadButton("download", "Download")
      ),
      tabItem(tabName = "Model",
        h2("Model specification"),
        p("A status (event, censored) and a time variable together with some covariate(s) are necessary in order to fit a survival model."),
        uiOutput("status"),
        uiOutput("time"),
        uiOutput("covariates"),
        uiOutput("strata"),
        checkboxInput("summary", "Summary of the model", TRUE)
      ),
      tabItem(tabName = "Report",
        helpText("We illustrate with Kaplan-Meier curve, followed by Cox model."),
        h3(textOutput("km_caption")),
        plotOutput("km"),
        h3(textOutput("cox_caption")),
        plotOutput("cox"),
        h3("Cox model summary"),
        verbatimTextOutput("coxfit"),
        h3("Model fit summary"),
        verbatimTextOutput("fit"),
        radioButtons('reportFormat', 'Report document format:', c('PDF', 'HTML', 'Word'), inline = TRUE),
        downloadButton("report", "Download report")
      )
    )
  )
)

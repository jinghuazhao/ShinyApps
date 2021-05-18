source("init.R")

ui <- dashboardPage(
  title = "shinySurvival",
  dashboardHeader(title = tags$a(href='https://github.com/jinghuazhao/ShinyApps', target = '_blank',
                                 tags$img(src=paste0("bees.svg"), height = "80%", width = "auto", align = "middle"))
                 ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Welcome", tabName = "landing", icon = icon("book-open")),
      menuItem("Upload-data", tabName = "Upload-data", icon = icon("dashboard")),
      menuItem("Kaplan-Meier", tabName = "Kaplan-Meier", icon = icon("th")),
      menuItem("Download-data", tabName = "Download-data", icon = icon("dashboard")),
      menuItem("Generate-report", tabName = "Generate-report", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "landing",
              div(class = "jumbotron", HTML("<center><h1>shinySurvival - a survival analysis taster</h1></center>")),
              fluidRow(
                fluidRow(div(class = "col-sm-12", div(class = "box box-primary", style = "padding-right: 5%; padding-left: 5%; font-size:110%", NULL, div(class = "box-body", shiny::includeMarkdown("README.md")))
              )))),
      tabItem(tabName = "Upload-data",
        h2("Upload a csv or tsv file"),
        fluidRow(
          fileInput("file", NULL, accept = c(".csv", ".tsv")),
          tableOutput("files"),
          tableOutput("preview")
        )
      ),
      tabItem(tabName = "Kaplan-Meier",
        h2("Kaplan-Meier plot"),
        plotOutput("km")
      ),
      tabItem(tabName = "Download-data",
        h2("Download a tsv version of the data"),
        downloadButton("download", "Download")
      ),
      tabItem(tabName = "Generate-report",
        h2("Generate analysis report"),
        downloadButton("report", "Generate report")
      )
     )
  )
)

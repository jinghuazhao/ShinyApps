source("init.R")

ui <- dashboardPage(
  title = "shinySurvival",
  dashboardHeader(title = tags$a(href='https://github.com/jinghuazhao/ShinyApps', target = '_blank',
                                 tags$img(src=paste0("bees.svg"), height = "70%", width = "auto", align = "middle")),
                  dropdownMenu(type = "messages",
                               tags$li(HTML('<li><a href="https://github.com/jinghuazhao/ShinyApps" target="_blank"><i class="fa fa-code-branch"></i><h4>GitHub</h4></a></li>')),
                               tags$li(HTML('<li><a href="mailto:jinghuazhao@hotmail.com" target="_blank"><i class="fa fa-question"></i><h4>email</h4></a></li>'))

                  )
                 ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "landing", icon = icon("home")),
      menuItem("Upload-data", tabName = "Upload-data", icon = icon("upload")),
      menuItem("Kaplan-Meier", tabName = "Kaplan-Meier", icon = icon("th")),
      menuItem("Download-data", tabName = "Download-data", icon = icon("download")),
      menuItem("Generate-report", tabName = "Generate-report", icon = icon("book-open"))
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

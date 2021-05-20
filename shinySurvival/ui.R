source("init.R")

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
      menuItem("Model", tabName = "Model", icon = icon("th")),
      menuItem("Download", tabName = "Download", icon = icon("download")),
      menuItem("Report", tabName = "Report", icon = icon("book-open"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "landing",
         div(class = "jumbotron", HTML("<center><h1>Shiny for Survival analysis</h1></center>")),
         fluidRow(
            fluidRow(div(class = "col-sm-12", 
                         div(class = "box box-primary", style = "padding-right: 5%; padding-left: 5%; font-size:100%", NULL,
                             div(class = "box-body", shiny::includeMarkdown("README.md"))
                         )
                     )
            )
         )
      ),
      tabItem(tabName = "Data",
        h2("Upload a csv or tsv file"),
        fluidRow(
          fileInput("file", NULL, accept = c(".csv", ".tsv")),
          tableOutput("files"),
          tableOutput("preview")
        )
      ),
      tabItem(tabName = "Model",
        h2("Model specification"),
        plotOutput("km")
      ),
      tabItem(tabName = "Download",
        h2("Download a tsv version of the data"),
        downloadButton("download", "Download")
      ),
      tabItem(tabName = "Report",
        h2("Generate analysis report"),
        downloadButton("report", "Report")
      )
    )
  )
)

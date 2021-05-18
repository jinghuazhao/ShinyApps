library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Test"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Upload", tabName = "Upload", icon = icon("dashboard")),
      menuItem("KM", tabName = "KM", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "Upload",
        fluidRow(
          box(plotOutput("plot1", height = 250)),
          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      ),
      tabItem(tabName = "KM",
        h2("Widgets tab content")
      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)

#!/usr/bin/bash

git add shinyapps
git commit -m "shinyapps"
git add shinySurvival
git commit -m "shinySurvival"
git add src
git commit -m "src"
git push

# source("ui.R");source("server.R");shiny::shinyApp(ui,server)

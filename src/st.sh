#!/usr/bin/bash

git add .gitignore
git commit -m ".gitignore"
git add shinyapps
git commit -m "shinyapps"
git add shinySurvival
git commit -m "shinySurvival"
git add src
git commit -m "src"
git push

# shiny::runApp()
# rsconnect::deployApp(forceUpdate=TRUE, logLevel="quiet")

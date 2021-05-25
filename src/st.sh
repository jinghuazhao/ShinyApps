#!/usr/bin/bash

git add .gitignore
git commit -m ".gitignore"
git add shinyapps
git commit -m "shinyapps"
git add shinySurvival
git commit -m "shinySurvival"
git add src
git commit -m "src"
git add README.md
git commit -m "README.md"
git push

# shiny::runApp()
# rsconnect::deployApp(forceUpdate=TRUE, logLevel="quiet")
# Rscript -e "knitr::knit('README.Rmd')"
# pandoc README.md --mathjax -s -o index.html

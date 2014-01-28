library(shiny)
library(shinysky)
library(shinyExt)
library(digest)

shinyServer(function(input, output, session) {
  
  # Tools ----
  source("tools//login.R", local=T)
  
  # Modules ----
  source("module//histogram.R", local=T)
  
  # main page ----
  output$mainPage <- renderUI({
    doLogin()
    if (loginData$LoggedIn) {
      doLogout()
      div(class="",
          fluidPage(fluidRow(column(12, column(4, br(), loginInfo()))),
        navbarPage(title="Login Showcase",
                   tabPanel("Histogram", br(), div(class=" ", ui_histogram()), id="subGroup"))
          ))
    } else {
      fluidPage(fluidRow(column(1, offset=5, br(), br(), br(), br(), h5("Login"), loginUI())),
                header= tags$style(type="text/css", "well { width: 100%; }"))
    }
  })
})

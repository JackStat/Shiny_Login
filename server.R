shinyServer(function(input, output, session) {
  
  source("module/histogram.R")
  
  # main page ----
  output$mainPage <- renderUI({
    doLogin()
    if (loginData$LoggedIn) {
      doLogout()
      div(class="",
          fluidPage(fluid=F, fluidRow(column(12, offset=3,
                                      column(4, br(), loginInfo())), responsive=F),
        navbarPage(title="Login Showcase",
                   tabPanel("Histogram", br(), div(class=" ", ui_histogram()), id="subGroup"))
          ))
    } else {
      fluidPage(fluidRow(column(1, offset=5, br(), br(), br(), br(), h5("Login"), loginUI())),
                header= tags$style(type="text/css", "well { width: 100%; }"))
    }
  })
})

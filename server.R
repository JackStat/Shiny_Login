shinyServer(function(input, output, session) {
  
  # Analysis ----
  output$ui_analysis <- renderUI({
      if (input$subGroups == "Startseite") {
        return()
      } else {
        div(class=" ", get(paste0('ui_',input$tool))())
      }
  })
  
  # main page ----
  output$mainPage <- renderUI({
    doLogin()
    if (loginData$LoggedIn) {
      doLogout()
      div(class="",
          fluidPage(fluid=F, fluidRow(column(12, offset=3,
                                      column(4, br(), loginInfo())), responsive=F),
        navbarPage(title="",
                   tabPanel("Startseite", br(), fluidRow(column(12, wellPanel(includeMarkdown("www/startseite.md")))), id="Startseite"),
                   tabPanel("Subgruppen-Analyse", br(), div(class=" ", ui_subGroups()), id="subGroup"),
                   tabPanel("Ähnliche Fälle", br(), div(class=" ", ui_simCases()), id="simcases"),
                   fluid=F,
                   responsive=F,
                   theme="css/bootstrap.css"
                   )
          ))
    } else {
      fluidPage(fluidRow(column(1, offset=5, br(), br(), br(), br(), h5("Login"), loginUI())),
                header= tags$style(type="text/css", "well { width: 100%; }"))
    }
  })
})

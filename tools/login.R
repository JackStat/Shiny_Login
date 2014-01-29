# Login information during session ----
loginData <- list()
loginData$LoggedIn <- FALSE


#  Demo User ----
# source for encryption: https://gist.github.com/ojessen/8656652
salt <- "278965644.305572987041471.293196"
hash <- digest(paste0(salt, "demo"), algo="sha256")

userTable <<- data.frame(user        = "demo",
                         login       = hash,
                         nacl        = salt)


# Login user interface ----
loginUI <- function (){
  div(class= "",
      textInput("account", "Account"), 
      passwordInput("pwd", "Passwort"), br(), br(),
      shinysky::actionButton("login", "Login", styleclass="success",icon = "ok")
  )
}


# Login info during session ----
loginInfo <- function() {
  fluidRow(
    column(3,
           "User: ", strong(loginData$Account)
    ),
    column(1, shinysky::actionButton("logout", "Logout", size="mini"))
  )
}


# Do login ----
doLogin <- reactive({
  if (!is.null(input$login)) {
    if (input$login > 0) {
      whichUser <- which(userTable$user == input$account)
      if(length(whichUser) > 0) {
        salt <- userTable$nacl[whichUser]
        hash <- digest(paste0(salt, input$pwd), algo="sha256")
        if(hash == userTable$login[whichUser]) {
          loginData$Account <<- input$account
          loginData$Session <<- "Session ID" # TODO
          loginData$LoginTime <<- Sys.time() # TODO
          loginData$LoggedIn <<- TRUE
        }
      }
    }
  }
})


# do logout ----
doLogout <- reactive({
  if (!is.null(input$logout)) {
    if (input$logout > 0) {
      isolate(
        loginData$LoggedIn <<- FALSE
      )
    }
  }
})
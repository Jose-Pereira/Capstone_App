shinyUI(pageWithSidebar( # standard shiny layout, controls on the
  # left, output on the right
  headerPanel("Next Word Prediction"), # give the interface a title
  sidebarPanel( # all the UI controls go in here
    textInput(inputId = "value", # this is the name of the
              # variable- this will be
              # passed to server.R
              label = "Write your word/phrase below", # display label for the
              # variable
              value = "write here" # initial value
    )
  ),
  mainPanel( # all of the output elements go in here
    h3("My prediction is"), # title with HTML helper
    textOutput("textDisplay") # this is the name of the output
    # element as defined in server.R
  )
))

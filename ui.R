library(shiny)
shinyUI(pageWithSidebar(
  headerPanel(HTML(
                   "&nbsp;Old Faithful Geyser Duration",'<img src="old_faithful.jpg" width=60 align=left>',"<br>",
                   "<span style='color:#999999; font-size:medium'>",
                   "&nbsp;&nbsp;&nbsp;&nbsp;...&nbsp;how long will this eruption last?</span>")),
  sidebarPanel(
    titlePanel("Usage"),
    p("At the very start of the geyser eruption, you can predict long it will last.  The data was compiled by",
      "measuring the waiting time and duration of eruptions for the Old Faithful geyser in Yellowstone National Park,",
      "Wyoming, USA.  At the very start of the eruption enter how long it's been since the last one ended to predict",
      "how long this eruption will last."),
    titlePanel("Settings"),
    tags$head(tags$style(type="text/css", 'input[type=number] { width: 3em; }')),
    h3('Wait Time'),
    numericInput('waittime', 'How long has it been since the last eruption? (in minutes)', 91, min = 1, max = 200, step=1),
    h3('Prediction Confidence'),
    p("You can provide a confidence range for your prediction.  The more confident you are in your prediction the",
      "larger the range.  You are giving up precision in your results in return for a larger range of confidence."),
    sliderInput('level', 'In percentage terms, how confident do you need to be in your prediction?', 
                .01, .99, .95, step = 0.01, format = "###%", ticks=T),

   submitButton('Submit')
  ),
  mainPanel(
    titlePanel('Server Calculation Results'),
    div(p(textOutput('reveal')), style="color:black; background-color:#F5F5F5; border: 2px solid black; padding: 2px 0px 2px 15px"),
    h3('Duration of Next Eruption'),
    h4('plot'),
    p(paste("The width of the blue bar correlates to the confidence level you've set.  The wider the bar the more confident we are",
      "in our prediction.  The longer the wait time before the geyser goes off, the more water it takes in before going off.",
      "As the bar moves to the right it correlates to the length of time the geyser will go off.")),
    plotOutput('myplot'),
    #h4('waittime'),
    #verbatimTextOutput("owaittime"),
    #h4('level'),
    #verbatimTextOutput("olevel"),
    h3("Precise Values"),
    h4('mean'),
    verbatimTextOutput('duration'),
    h4('low'),
    verbatimTextOutput('low'),
    h4('high'),
    verbatimTextOutput('high')
  )
))
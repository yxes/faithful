library(shiny)
library(ggplot2)

data(faithful)
fit <- lm(eruptions ~ waiting, data=faithful)

duration <- function (waiting=65, level=.95) {
  predict(fit, data.frame(waiting), interval="predict", level=level)
}

shinyServer(
 
  function(input, output) {
    results <- reactive({duration(waiting = input$waittime, level = input$level)})
    
    output$owaittime <- renderPrint({input$waittime})
    output$olevel    <- renderPrint({input$level})
    
    output$reveal    <- renderText({
      paste("Since it's been ", input$waittime, " minutes since the geyser erupted. We are ", input$level*100, 
            "% confident that Old Faithful will erupt for between ", round(results()[2], digits=2), 
            " and ", round(results()[3], digits=2), " minutes this time, the average time being ", 
            round(results()[1], digits=2), " minutes.", sep="")
    })
    output$duration  <- renderPrint({results()[1]})
    output$low       <- renderPrint({results()[2]})
    output$high      <- renderPrint({results()[3]})
    
    boxPlot <- function() {
        sdf <- data.frame(duration = results()[1:3], ind = c('A1','A2','A3'), group = rep('',3), obs=1:3)
        plot1 <- ggplot(sdf, aes(x="", y=duration, fill="")) + geom_boxplot(notch=F) + coord_flip() + ylim(c(-2.5, 14.3)) +
          ylab("eruption duration in minutes") + xlab(NULL) + guides(fill=FALSE) +
          scale_fill_manual(values=c("#56A8E1")) + theme_bw();
        print(plot1)
    }
    
    output$myplot <- renderPlot({
      boxPlot()
    })
    
    #output$myplot    <- renderPlot({boxplot(results()[1:3], horizontal=T, ylim=c(-2.5,14.3), varwidth=T)})
    
  }
)
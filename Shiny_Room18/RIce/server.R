library(shiny)
library(tidyverse)
library(DT)

data.pheno.pca <- read_csv("data.pheno.pca.csv", na=c("NA","00"))
# Define server logic required to draw a boxplot
shinyServer(function(input, output) {
  
  # Expression that generates a boxplot. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$ricedata <- renderPlot({
    FirstPC <- as.name(input$FirstChoice)
    SecondPC <- as.name(input$SecondChoice)
    Attribute.option <- as.name(input$attribute) # convert string to name
    
    # set up the plot
    ggplot(data.pheno.pca, aes(x= !!FirstPC, y=!!SecondPC, color=!!Attribute.option)) +
      geom_point()
    # draw the boxplot for the specified trait
  })
  
})
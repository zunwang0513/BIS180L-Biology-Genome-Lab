library(shiny)
library(tidyverse)
library(DT)

PCchoice <- c("PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10")
# Define UI for application that draws a histogram
shinyUI(fluidPage( #create the overall page
  
  # Application title
  titlePanel("The Colorized Races of Rice"),
  
  # Some helpful information
  helpText("This application shows clustering of different regions that contain different kinds of rice SNPs",
           "Amylose content for different species of rice as associated with the region, please use the radio box below to choose two populations and an attribute",
           "for plotting"),
  
  # Sidebar with a radio box to input which trait will be plotted
  sidebarLayout(
    sidebarPanel(
      selectizeInput(
        "FirstChoice",
        "Make your first choice:",
        PCchoice
      ),
      selectizeInput(
        "SecondChoice",
        "Make your second choice:",
        PCchoice
      ),
      selectizeInput(
        "attribute",
        "What attribute you want to display:",
        c("Amylose content","Pericarp color","Region","Seed length","Seed volume","Plant height","Seed number per panicle")
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
      #plotOutput("boxPlot"),
      plotOutput("ricedata")
    )
  )
))
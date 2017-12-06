# Server file for final project

library(shiny)
library(dplyr)

# Set working directory
# setwd('~/documents/documents/uw_homework/info_201/assignments/x-men')

# Read in the data
source('./data/comicvine-data.R')

shinyServer(function(input, output) {
  
  # Make the barchart of characters by gender per publisher
  output$chart <- renderPlot({
    # Grab all the male characters from the inputted publisher
    publisher.male.characters <- male.characters %>%
      filter(publisher.name == input$publisher)
    
    # Grab all the female characters from the inputted publisher
    publisher.female.characters <- female.characters %>%
      filter(publisher.name == input$publisher)
    
    # Render the bar chart
    
  })
})


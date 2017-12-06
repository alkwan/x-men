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
    
    # Plot the bar chart
    
  })
  
  output$character.comparison <- renderTable({
    # Get the female character data
    female.character <- female.characters %>%
      filter(name == input$female)
    
    # Get the male character data
    male.character <- male.characters %>%
      filter(name == input$male)
    
    # Make the comparison table
  })
})


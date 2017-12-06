# Server file for final project

library(shiny)
library(dplyr)

# Set working directory
# setwd('~/documents/documents/uw_homework/info_201/assignments/x-men')

# Read in the data
source('./data/comicvine-data.R')
source('comic-vine.R')

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
    # female.character <- female.characters %>%
    #   filter(name == input$female)
    data.chosen.female <- CharacterAllInfo('Superman')
    convert.all.female <- tryCatch(
      CharacterChosenInfo(data.chosen.female),
      error = function(error_message) {
        powers.female <- "Not available"
      })
    if(convert.all.female[1] == "Not available") {
      powers.female <- "Not available"
    } else {
      powers.female <- GetPowers(convert.all.female)
    }
    date.female <- GetDate(data.chosen.female)
    appearances.female <- data.chosen.female$count_of_issue_appearances
    
    # Get the male character data
    # male.character <- male.characters %>%
    #   filter(name == input$male)
    data.chosen.male <- CharacterAllInfo(input$male)
    convert.all.male <- tryCatch(
      CharacterChosenInfo(data.chosen.male),
      error = function(error_message) {
        powers.male <- "Not available"
      })
    if(convert.all.male[1] == "Not available") {
      powers.male <- "Not available"
    } else {
      powers.male <- GetPowers(convert.all.male)
    }
    date.male <- GetDate(data.chosen.male)
    appearances.male <- data.chosen.male$count_of_issue_appearances
    
    # Make the comparison table
  })
})


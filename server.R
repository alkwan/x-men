# Server file for final project

library(shiny)
library(dplyr)

# Set working directory
# setwd('~/documents/documents/uw_homework/info_201/assignments/x-men')

# Read in the data
source('./data/comicvine-data.R')
# source('./data/random.R')
source('comic-vine.R')

source('./scripts/GenerateBarchart.R')
source('./scripts/makePieChart.R')

shinyServer(function(input, output) {
  female.chosen <- reactive({female.characters %>% filter(name == input$female)})
  male.chosen <- reactive({male.characters %>% filter(name == input$male)})
  src.1 <- reactive({female.chosen()$image.screen_url})
  src.2 <- reactive({male.chosen()$image.screen_url})
  output$picture.1<-renderText({c('<img src="',src.1()[1],'">')})
  output$picture.2<-renderText({c('<img src="',src.2()[1],'">')})
  
  # Make the barchart of characters by gender per publisher
  #output$chart <- renderPlotly({
  #  # Plot the bar chart
  #  generateBarchart(comicvine.data, input$publisher1, input$publisher2)
  #})
  
  #output$pie <- renderPlotly({
  #  # Plot the pie charts
  #  makePieChart(comicvine.data, input$publisher1, input$publisher2)
  #})
  
  output$type_of_chart <- renderPlotly({ 
    if(input$type == "Bar Chart") {
      generateBarchart(comicvine.data, input$publisher1, input$publisher2)
    } else {
      makePieChart(comicvine.data, input$publisher1, input$publisher2)
    }
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


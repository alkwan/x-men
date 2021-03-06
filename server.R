# Server file for final project
# Load the libraries
library(shiny)
library(dplyr)

# Read in the data
source('./data/comicvine-data.R')
source('comic-vine.R')

# Read in the required scripts
source('./scripts/GenerateBarchart.R')
source('./scripts/makePieChart.R')
source('./scripts/bestGenderRatio.R')
source('./scripts/table.R')

shinyServer(function(input, output) {
  # Picture output for character comparison
  female.chosen <- reactive({female.characters %>% filter(name == input$female)})
  male.chosen <- reactive({male.characters %>% filter(name == input$male)})
  male.name <- reactive({male.names %>% filter(name == input$male)})
  female.name <- reactive({female.names %>% filter(name == input$female)})
  src.1 <- reactive({female.chosen()$image.small_url})
  src.2 <- reactive({male.chosen()$image.small_url})
  output$picture.1<-renderText({c('<img src="',src.1()[1],'">')})
  output$picture.2<-renderText({c('<img src="',src.2()[1],'">')})
  
  # Data wrangling for the number of issue appearances for the chosen male character
  male.appearance <- reactive({data <- male.chosen()$count_of_issue_appearances
                                data <- data[1]
                                return(data)})
  comparison.male.frame <- reactive({comparison.data <- data.frame(male.name(), male.appearance())
                                return(comparison.data)})
  
  # Data wrangling for the number of issue appearances for the chosen female character
  female.appearance <- reactive({data <- female.chosen()$count_of_issue_appearances
  data <- data[1]
  return(data)})
  comparison.female.frame <- reactive({comparison.data <- data.frame(female.name(), female.appearance())
  return(comparison.data)})
  
  # The table output for the male character data
  output$character.male.comparison <- renderTable({
    head(comparison.male.frame(), n = 6)},
    bordered = TRUE,
    hover = TRUE, spacing = 'l',
    align = 'c')
  
  # The table output for the female character data
  output$character.female.comparison <- renderTable({
    head(comparison.female.frame(), n = 6)},
    bordered = TRUE,
    hover = TRUE, spacing = 'l',
    align = 'c')
  
  # Output either the bar chart or the pie chart.
  output$type_of_chart <- renderPlotly({ 
    if(input$type == "Bar Chart") {
      generateBarchart(comicvine.data, input$publisher1, input$publisher2)
    } else {
      makePieChart(comicvine.data, input$publisher1, input$publisher2)
    }
  })
  
  # Output the table of top 50 publishers and their gender ratios
  output$gender.table <- renderDataTable(bestGenderRatio(comicvine.data))
})


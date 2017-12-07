library(shinysky)
library(shiny)
library(ggplot2)
library(hexbin)
library(shinythemes)
library(plotly)
library(js)
source('./data/comicvine-data.R')


  
  parameters <- c("A", "B", "C", "D")

shinyUI(
  navbarPage(
    theme = shinytheme("united"),"Gender Diversity in Comics", position = "static-top",
      
    tabPanel("Project Description",
      h2("About our Project"),
      p("The comic book industry is often thought of as a boys club, but it's 2017 and feminism seems to be on the rise.
      Gender equality initiatives seem to be happening all over the STEM field, but is it happening in comics? To find out,
      we looked at ",a("Comic Vine", href = "https://comicvine.gamespot.com/api/"),"'s API. Our goal with this project is to
      see if there are any disparities between gender when it comes to comic book characters. If there are, where do they
      appear?"),
                     
      h2("The Data"),
      p("We sorted through Comic Vine's extensive comic book character data in order to determine..."),
                     
      h2("Our Audience"),
      p("Some description of our audience.")
    ),
                   
  tabPanel("Superhero Comparison",sidebarLayout(
        
      sidebarPanel(
        h3("need a title"),
        br(),
        selectizeInput("female", "Female Superhero", female.names, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name')),
        selectizeInput("male", "Male Superhero", male.names, selected = male.names[1], multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name'))
        ),
                
      mainPanel(
        h4("Character Comparison"),
        splitLayout(cellwidths=c("50%","50%"),htmlOutput("picture.1"),htmlOutput("picture.2"))
      )
    )
  ),   
          
    tabPanel("Report by Publisher", sidebarLayout(
      sidebarPanel(
        h4("Gender by Publisher"),
        selectizeInput("publisher1", "Publisher 1", publishers, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                                      onInitialize = I('function() { this.setValue("DC Comics"); }'))),
        selectizeInput("publisher2", "Publisher 2", publishers, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                                      onInitialize = I('function() { this.setValue("Marvel"); }')))
      ),
      
      mainPanel(
        h4("Description"),
        p("Type in two publisher names and see the number breakdown of their female and male characters.
          Switch between bar charts and pie charts to see numbers versus percentages."),
        plotlyOutput('chart'),
        plotlyOutput('pie')
      )
    )
  ),
                   
    tabPanel("Report by year", 
             tags$head(tags$style(HTML(".multicol{font-size:15px;
                                                  height:balance;
                                       -webkit-column-count: 2;
                                       -moz-column-count: 2;
                                       column-count: 2;
                                       }
                                       
                                       div.checkbox {margin-top: -10px;
                                       margin-bottom: -25px;}"))),
          
      sidebarLayout(
        sidebarPanel(
          controls <-list(tags$div(align = 'left', 
                                   class = 'multicol', 
                                   radioButtons(inputId  = 'year', 
                                                label = "",
                                                choices  = NULL,
                                                selected = NULL,
                                                inline   = FALSE, 
                                                choiceNames = c("2000", "2001", "2002", "2003", "2004", "2005"), 
                                                choiceValues = c(2000, 2001, 2002, 2003, 2004, 2005)
                                   ))),
          
          h4("need a title"),
          radioButtons("test", "Select a year", choices = NULL, selected = NULL,
                       inline = FALSE, width = NULL, choiceNames = c("2000", "2001"), choiceValues = c(2000, 2001))
        ),
      
        mainPanel(dataTableOutput("shotlog"))
      )
    )
  )
)

library(shinysky)
library(shiny)
library(ggplot2)
library(hexbin)
library(shinythemes)
library(plotly)
library(js)
source('./data/comicvine-data.R')
shinyUI(
  navbarPage(
    theme = shinytheme("united"),"Gender Diversity in Comics", position = "static-top",
      
    tabPanel("Project Description", sidebarLayout(
      sidebarPanel(
        width = 4,
        h4("About Our Project"),
        p("The comic book industry is often thought of as a boys club, but it's 2017 and feminism seems to be on the rise.
          Gender equality initiatives seem to be happening all over the STEM field, but is it happening in comics? To find out,
          we looked at ",a("Comic Vine", href = "https://comicvine.gamespot.com/api/"),"'s API. Our goal with this project is to
          see if there are any disparities between gender when it comes to comic book characters. If there are, where do they
          appear?"),
        
        h4("The Data"),
        p("We sorted through Comic Vine's extensive comic book character data, getting over 100,000 results to analyze.
          We've chosen to visualize the data in the following ways: a side by side character comparison chart (male vs female),
          a bar chart showing the number of female and male characters per publisher (and comparing the two), and a line graph
          showing the number of male and female characters created each year."),
        
        h4("Our Audience"),
        p("As stated earlier, comic fans and the comic book industry are often seen as a boy's club. But we
          believe that comics should be inclusive and for everyone. We hope to reach and encourage any girls who
          wonder if they, too, have a place in comic book fandom. We also hope to reach publishers and creators to show that,
          even in 2017, gender equity is still lacking.")
        ),
      mainPanel(
        img(src='https://comicvine.gamespot.com/api/image/scale_small/5505344-bpsyxk4ciyn8odvaxpoj.png')
      )
      )
    ),
                   
    tabPanel("Superhero Comparison",sidebarLayout(
        
      sidebarPanel(
        h4("Female and Male Superhero Comparisons"),
        p("Enter the name of a female character and a male character to compare their images and
          characteristics."),
        selectizeInput("female", "Female Superhero", female.names, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                                      onInitialize = I('function() { this.setValue("Kamala Khan"); }'))),
        selectizeInput("male", "Male Superhero", male.names, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name',
                                      onInitialize = I('function() { this.setValue("Damian Wayne"); }')))
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
        p("Type in two publisher names and see the number breakdown of their female and male characters.
          Switch between bar charts and pie charts to see numbers versus percentages."),
        selectizeInput("publisher1", "Publisher 1", publishers, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                                      onInitialize = I('function() { this.setValue("DC Comics"); }'))),
        selectizeInput("publisher2", "Publisher 2", publishers, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                                      onInitialize = I('function() { this.setValue("Marvel"); }'))),
        radioButtons("type", "Select the type of chart", choices = c("Bar Chart", "Pie Chart"), selected = NULL,
                     inline = FALSE, width = NULL)
      ),
      
      mainPanel(
        br(),
        br(),
        br(),
        plotlyOutput('type_of_chart', height = 500, width = 600)
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
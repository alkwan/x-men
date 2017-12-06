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
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                       onInitialize = I('function() { this.setValue(""); }'))),
        selectizeInput("male", "Male Superhero", male.names, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                                      onInitialize = I('function() { this.setValue(""); }')))
        ),
                
      mainPanel(
        h4("Shot Chart of Players"),
        splitLayout(cellwidths=c("50%","50%"),plotOutput("plot9"),plotOutput("plot10")),
        h4("Comparison of shot attempts"),
        splitLayout(cellwidths=c("50%","50%"),plotlyOutput("plot11"),plotlyOutput("plot12")),
        h4("Comparison of % Field Goal"),
        splitLayout(cellwidths=c("50%","50%"),plotlyOutput("plot13"),plotlyOutput("plot14")),
        h4("Comparison of shooting preference by Distance"),
        plotlyOutput("plot15"),
        h4("Comparison of Offense Diversity (Bar)"),
        splitLayout(cellwidths=c("50%","50%"),plotlyOutput("plot16"),plotlyOutput("plot17")),
        h4("Comparison of Offense Diversity (Pie)"),
        splitLayout(cellwidths=c("50%","50%"),plotlyOutput("plot18"),plotlyOutput("plot19"))
        ))
      ),
        
          
    tabPanel("Report by Publisher", sidebarLayout(
      sidebarPanel(
        h4("need a title"),
        selectizeInput("publisher", "Publisher", publishers, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                                      onInitialize = I('function() { this.setValue(""); }')))
      ),
      
      mainPanel(
        h4("Description"),
        p(h5("This special part serves the research function of re-clustering the habit of shot of players. Traditionally, the league always cluster the shot of players by the defined area of the court. However, the revolution of the training technique makes some players really crazy. Therefore, it is not quite scientific to research the shot data by the traditional court division. Therefore, we implement K-means cluster analysis to re-group the shot data of each player. We believe that clustering the shot data for each player will be beneficial to formulate the defending strategy against the player. For a commonly asked question referring to the cluster analysis, the number of clusters, we think the # of clusters is better decided by the user him/herself. The scientific number of clusters can be visualized by the specific shooting plot",align="Justify")),
        h4("Clustering analysis for all shot data"),
        p(h5("Firstly, we group all data of the player. Different colors represent different clusters")),
        fluidRow(column=8,
                  plotOutput("plotc1",width = "800", height = "600"),align="Center"),
                  br(),
                  h4("Clustering analysis for all made shot"),
                  p(h5("Also, a similar analysis is conducted with the data of made shot. The player may be able to shoot more accurately in some specific area. Therefore, clustering the made shot will be also helpful to formulate a specific defending strategy."),align="Justify"),
        fluidRow(column=8,
                  plotOutput("plotc2",width = "800", height = "600"),align="Center")
                              
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
                                              choiceValues = c(2000, 2001, 2002, 2003, 2004, 2005)) 
                                 )),
        
        h4("need a title"),
        radioButtons("test", "Select a year", choices = NULL, selected = NULL,
                     inline = FALSE, width = NULL, choiceNames = c("2000", "2001"), choiceValues = c(2000, 2001))
      ),
      
      mainPanel(dataTableOutput("shotlog"))
    )
    )
  )
)
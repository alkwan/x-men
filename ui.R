library(shinysky)
library(shiny)
library(ggplot2)
library(hexbin)
library(shinythemes)
library(plotly)

source('./data/comicvine-data.R')

shinyUI(navbarPage(theme = shinytheme("lumen"),"Not named yet", position = "fixed-top",
                   tabPanel("Project Description",
                     mainPanel(
                       
                     
                   )),
                   
                   tabPanel("Superhero Comparison",sidebarLayout(
                      sidebarPanel(
                        h4("need a title"),
                        select2Input("a",label = "Superhero A","",choices=as.character(character.names),type = c("input", "select")),
                        select2Input("b", label = "Superhero B","",choices=as.character(character.names),type = c("input", "select"))
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
                      select2Input("publisher", label = "Select a publisher","",choices=as.character(publishers),type = c("input", "select"))
                    
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
                                
                                
                              ))
                  ),
                   
                  tabPanel("Report by year", sidebarLayout(
                    sidebarPanel(
                      h4("need a title"),
                      select2Input("year", label = "Select a year","",choices=as.character(character.names),type = c("input", "select"))
                    ),
                    mainPanel(dataTableOutput("shotlog"))
                  ))
))
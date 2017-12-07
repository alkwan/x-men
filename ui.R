# Load the libraries
library(shinysky)
library(shiny)
library(ggplot2)
library(hexbin)
library(shinythemes)
library(plotly)
library(js)

# Source in the data
source('./data/comicvine-data.R')

# UI for our final project
shinyUI(
  navbarPage(
    theme = shinytheme("united"),"Gender Diversity in Comics", position = "static-top",
    
    # Project description tab
    tabPanel("Project Description", sidebarLayout(
      sidebarPanel(
        h4("About Our Project"),
        p("The comic book industry is often thought of as a boys club, but it's 2017 and feminism seems to be on the rise.
          Gender equality initiatives seem to be happening all over the STEM field, but is it happening in comics? To find out,
          we looked at ",a("Comic Vine", href = "https://comicvine.gamespot.com/api/"),"'s API. Our goal with this project is to
          see if there are any disparities between gender when it comes to comic book characters. If there are, where do they
          appear?"),
        
        h4("The Data"),
        p("We sorted through Comic Vine's extensive comic book character data, getting over 100,000 results to analyze.
          We've chosen to visualize the data in the following ways: a side by side character comparison chart (male vs female),
          a bar chart showing the number of female and male characters per publisher (and comparing the two), and a table showing
          the 50 largest publishers sorted by best female to male gender ratio."),
        
        h4("Our Audience"),
        p("As stated earlier, comic fans and the comic book industry are often seen as a boy's club. But we
          believe that comics should be inclusive and for everyone. We hope to reach and encourage any girls who
          wonder if they, too, have a place in comic book fandom. We also hope to reach publishers and creators to show that,
          even in 2017, gender equity is still lacking."),
        
        h4("A Note on Gender"),
        p("The authors of this project would like to acknowledge that gender diversity
          does not just mean male and female, but includes nonbinary genders as well.
          Comic Vine's API includes three designations for character gender--male, female,
          and other. Unfortunately, the 'other' designation included animal characters and
          nonhuman nongendered characters (like a character who is actually made of garbage).
          We hope Comic Vine updates their API to reflect nonbinary characters in the future.")
        ),
      mainPanel(
        img(src='https://comicvine.gamespot.com/api/image/scale_small/5505344-bpsyxk4ciyn8odvaxpoj.png')
      )
      )
    ),
    
    # Tab where we compare a female superhero and male superhero             
    tabPanel("Superhero Comparison",sidebarLayout(
        
      sidebarPanel(
        width = 3,
        h4("Female and Male Superhero Comparisons"),
        p("Enter the name of a female character and a male character to compare their images and
          the number of times they've appeared in comic book issues."),
        selectizeInput("female", "Female Superhero", female.names, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name', 
                                      onInitialize = I('function() { this.setValue("Kamala Khan"); }'))),
        selectizeInput("male", "Male Superhero", male.names, multiple = FALSE,
                       options = list(maxOptions = 5, placeholder = 'Please type in the name',
                                      onInitialize = I('function() { this.setValue("Damian Wayne"); }')))
        ),
                
      mainPanel(
        splitLayout(cellwidths=c("50%", "50%"),htmlOutput("picture.1"),htmlOutput("picture.2")),
        splitLayout(cellwidths=c("50%", "50%"),tableOutput('character.female.comparison'),tableOutput('character.male.comparison'))
      )
    )
  ),   
    
  # Tab where we compare publishers and their character gender breakdowns     
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
        plotlyOutput('type_of_chart', height = 500, width = 600)
      )
    )
  ),
   
  # Tab where we looked at the 50 largest publishing companies' gender ratios                
    tabPanel("Gender Ratios", 
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
          h4("Who has the best gender ratio?"),
          p("We were curious to see who, out of the 50 largest publishers, had the 
            greatest female to male gender ratio. Largest publisher was determined by
            total number of characters. We chose this because simply looking at publishers
            with the highest ratios were mostly adult and erotic comics, which we didn't
            want to include.")
        ),
      
        mainPanel(dataTableOutput("gender.table"))
      )
    )
  )
)
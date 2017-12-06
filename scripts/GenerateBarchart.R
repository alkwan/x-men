# Load Libraries 
library(dplyr)
library(plotly)

# Import comicvine data 
source('./data/comicvine-data.R')
#source('./data/random.R')

gender.counts <- comicvine.data %>%
  group_by(publisher.name) %>%
  count(gender)

# Function to generate barchart of gender diversity by publisher
generateBarchart <- function(data, publisher1 = 'DC Comics', publisher2 = 'Marvel') {

  desired.publishers <- gender.counts %>%
    filter((publisher.name == publisher1 | publisher.name == publisher2) &
             (gender == 1 | gender == 2))
  
  without.publisher <- desired.publishers %>%
    ungroup() %>%
    select(gender, n)
  
  males <- without.publisher %>%
    filter(gender == 1) %>%
    select(n)
  
  females <- without.publisher %>%
    filter(gender == 2) %>%
    select(n)
  
  publisher.name <- c(unique(desired.publishers$publisher.name))
  desired.df <- data.frame(publisher.name, males, females)
  colnames(desired.df)[2:3] <- c("males", "females")
  
  p <- plot_ly(desired.df, x = ~publisher.name, y = ~males, type = 'bar', name = "Males", 
               marker=list(color='rgb(79, 160, 75)')) %>%
    add_trace(y = ~females, name = "Females", marker=list(color='rgb(232, 186, 81)')) %>%
    layout(title = paste("Gender of Comic Book Characters by Publisher"),
           xaxis = list(title = "Publisher"),
           yaxis = list(title = "Count")
    )
  return(p)
}

generateBarchart(comicvine.data,"Marvel", "DC Comics")


# Load Libraries 
library(dplyr)
library(plotly)

# Groups comicvine data by publisher and counts number of each gender
gender.counts <- comicvine.data %>%
  group_by(publisher.name) %>%
  count(gender)

# Function to generate barchart to compare gender (count) by publisher
generateBarchart <- function(data, publisher1 = 'DC Comics', publisher2 = 'Marvel') {
  
  # Filters dataframe to only include data on desired publishers and
  # counts of Males and Females 
  desired.publishers <- gender.counts %>%
    filter((publisher.name == publisher1 | publisher.name == publisher2) &
             (gender == 1 | gender == 2))
  
  # Creates dataframe with only gender and counts 
  without.publisher <- desired.publishers %>%
    ungroup() %>%
    select(gender, n)
  
  # Creates dataframe males with counts of number of males
  # from desired publishers 
  males <- without.publisher %>%
    filter(gender == 1) %>%
    select(n)
  
  # Creates dataframe with females with counts of number of females
  # from desired publishers 
  females <- without.publisher %>%
    filter(gender == 2) %>%
    select(n)
  
  # Creates desired dataframe with publisher name, males (counts), 
  # and females (count) as colmns 
  publisher.name <- c(unique(desired.publishers$publisher.name))
  desired.df <- data.frame(publisher.name, males, females)
  colnames(desired.df)[2:3] <- c("males", "females")
  
  # Creates a barchart out of desired dataframe of gender by publisher
  p <- plot_ly(desired.df, x = ~publisher.name, y = ~males, type = 'bar', name = "Males", 
               marker=list(color='rgb(79, 160, 75)')) %>%
    add_trace(y = ~females, name = "Females", marker=list(color='rgb(232, 186, 81)')) %>%
    layout(title = paste("Gender of Comic Book Characters by Publisher"),
           xaxis = list(title = "Publisher"),
           yaxis = list(title = "Count")
    )
  return(p)
}


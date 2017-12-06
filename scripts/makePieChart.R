# Pie chart function

# Load the libraries
library(plotly)
library(tidyverse)

makePieChart <- function(data, publisher1, publisher2) {
  # Sort the data into gender counts
  gender.counts <- data %>%
    group_by(publisher.name) %>%
    count(gender)
  
  # Filter by publisher
  desired.publishers <- gender.counts %>%
    filter((publisher.name == publisher1 | publisher.name == publisher2) &
             (gender == 1 | gender == 2))
  
  # Remove publishers from data
  without.publisher <- desired.publishers %>%
    ungroup() %>%
    select(gender, n)
  
  # Get the counts of each gender for the first
  # publisher and rename the columns
  publisher1.count <- data.frame(gender = c("male", "female"), without.publisher[1:2, 2])
  colnames(publisher1.count) <- c("gender", "num")
  
  # Get the counts of each gender for the
  # second publisher and rename the columns
  publisher2.count <- data.frame(gender = c("male", "female"), without.publisher[3:4, 2])
  colnames(publisher2.count) <- c("gender", "num")
  
  # Color palette for the pie chart
  colors <- c('rgb(211,94,96)', 'rgb(144,103,167)')
  
  # Render both pie charts
  pies <- plot_ly() %>%
    add_pie(data = publisher1.count, labels = ~gender, values = ~num,
            textposition = 'inside', textinfo = 'label+percent',
            insidetextfont = list(cplor = '#FFFFFF'),
            hoverinfo = 'text',
            text = ~paste(num, "characters"),
            marker = list(colors = colors,
                          line= list(color = '#FFFFFF', width = 1)),
            showlegend = FALSE,
            domain = list(x = c(0, 0.4), y = c(0.4, 1))) %>%
    add_pie(data = publisher2.count, labels = ~gender, values = ~num,
            textposition = 'inside', textinfo = 'label+percent',
            insidetextfont = list(cplor = '#FFFFFF'),
            hoverinfo = 'text',
            text = ~paste(num, "characters"),
            marker = list(colors = colors,
                          line= list(color = '#FFFFFF', width = 1)),
            showlegend = FALSE,
            domain = list(x = c(0.6, 1), y = c(0.4, 1))) %>%
    layout(title = ~paste('Characters by Gender at', publisher1, 'vs', publisher2),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  return(pies)
  
}

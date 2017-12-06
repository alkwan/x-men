# Server file for final project

library(shiny)
library(dplyr)

# Read in data
source('data/comicvine-data.R')

male.characters <- comicvine.data %>%
  select(name, gender, image.small_url, publisher.name)

# File to combine .csv files 
library(dplyr)

# Read in CSVs
comicvine.data1 <- read.csv('data/comicvine_data1.csv', stringsAsFactors = FALSE, fileEncoding = 'latin1')
comicvine.data2 <- read.csv('data/comicvine_data2.csv', stringsAsFactors = FALSE, fileEncoding = 'latin1')
comicvine.data3 <- read.csv('data/comicvine_data3.csv', stringsAsFactors = FALSE, fileEncoding = 'latin1')

# Combine CSVs
comicvine.data <- rbind(comicvine.data1, comicvine.data2, comicvine.data3)

# Get all available publisher names
publishers <- comicvine.data %>%
  select(publisher.name) %>%
  unique()

# Get all male characters
male.characters <- comicvine.data %>%
  select(name, real_name, gender, image.screen_url, image.small_url, publisher.name, count_of_issue_appearances) %>%
  filter(gender == '1')

# Get all male characters' names
male.names <- male.characters %>% select(name) %>% unique()

# Get all female characters' names
female.characters <- comicvine.data %>%
  select(name, real_name, gender, image.screen_url, image.small_url, publisher.name, count_of_issue_appearances) %>%
  filter(gender == '2')

# Get all female characters
female.names <- female.characters %>% select(name) %>% unique()
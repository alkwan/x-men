# File to combine .csv files 
library(dplyr)

comicvine.data1 <- read.csv('data/comicvine_data1.csv', stringsAsFactors = FALSE, fileEncoding = 'latin1')
comicvine.data2 <- read.csv('data/comicvine_data2.csv', stringsAsFactors = FALSE, fileEncoding = 'latin1')
comicvine.data3 <- read.csv('data/comicvine_data3.csv', stringsAsFactors = FALSE, fileEncoding = 'latin1')


comicvine.data <- rbind(comicvine.data1, comicvine.data2, comicvine.data3)

publishers <- comicvine.data %>%
  select(publisher.name) %>%
  unique()

male.characters <- comicvine.data %>%
  select(name, real_name, gender, image.small_url, publisher.name) %>%
  filter(gender == '1')

female.characters <- comicvine.data %>%
  select(name, real_name, gender, image.small_url, publisher.name) %>%
  filter(gender == '2')

dc.male.characters <- male.characters %>%
  filter(publisher.name == 'DC Comics')

dc.female.characters <- female.characters %>%
  filter(publisher.name == 'DC Comics')

marvel.male.characters <- male.characters %>%
  filter(publisher.name == 'Marvel')

marvel.female.characters <- comicvine.data %>%
  select(name, real_name, gender, image.small_url, publisher.name) %>%
  filter(gender == '2') %>%
  filter(publisher.name == 'Marvel')

image.male.characters <- male.characters %>%
  filter(publisher.name == 'Image')

image.female.characters <- female.characters %>%
  filter(publisher.name == 'Image')

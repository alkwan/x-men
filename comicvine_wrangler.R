# Wrangle data from comicvine API to a managable .csv file
library(jsonlite)
library(dplyr)
library(httr)

api.key <- "0f3a5dfbd8ce531b429e17f42637bd1738f1cd64"

offset <- 0
desired.df <- data.frame()

# Loop to get all character data from comicvine API into one 
# dataframe 
for(i in 1:1210) {
  base.url <- 'http://www.comicvine.com/api/characters'
  resource <- paste0('/?api_key=', api.key, '&offset=', offset, '&format=json')
  url.full <- paste0(base.url, resource)
  response <- GET(url.full)
  body <- content(response, 'text')
  parsed.data <- fromJSON(body)
  
  results <- flatten(parsed.data$results)
  desired.df <- rbind(desired.df, results)
  
  offset = offset + 100;
}

#Write the desired.df of character data into a csv file
write.csv(desired.df, file = "comicvine_data.csv", row.names = FALSE)

#Break up the large csv file into three csv files under 100mb
large.file <- read.csv('comicvine_data.csv', stringsAsFactors = FALSE)
comicvine1 <- large.file[1:20000, ]
comicvine2 <- large.file[20001:55000, ]
comicvine3 <- large.file[55001:102600, ]

write.csv(comicvine1, file="comicvine_data1.csv", row.names = FALSE)
write.csv(comicvine2, file="comicvine_data2.csv", row.names = FALSE)
write.csv(comicvine3, file="comicvine_data3.csv", row.names = FALSE)
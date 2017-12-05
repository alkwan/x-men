library(jsonlite)
library(dplyr)
library(httr)

source('comic.R')

url <- "http://comicvine.gamespot.com/api/"
api <- "/?api_key="
test <- paste0(url, 'characters', api, comic.vine, '&filter=gender:female&field_list=name,birth,publisher,first_appeared_in_issue,image,origin&format=json')
response <- GET(test)
body <- content(response, "text")
results <- fromJSON(body) 
data.gender <- flatten(results$results) #Gender data with other information included

# Work in Progress
character <- paste0(url, 'character', api, comic.vine, '&field_list=name&format=json')
response.character <- GET(character)
body.character <- content(response.character, "text")
results.character <- fromJSON(body.character)
data.character <- flatten(results.character$results)
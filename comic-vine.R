library(jsonlite)
library(dplyr)
library(httr)

source('comic.R')

url <- "http://comicvine.com/api/"
api <- "/?api_key="

# Gender data
gender.url <- paste0(url, 'characters', api, comic.vine, '&filter=gender:female&field_list=name,id,birth,publisher,first_appeared_in_issue,image,count_of_issue_appearances&format=json')
gender.response <- GET(gender.url)
gender.body <- content(gender.response, "text")
gender.results <- fromJSON(gender.body) 
data.gender <- flatten(gender.results$results)

# Character chosen by user
name <- "wonder woman"
chosen.url <- paste0(url, 'characters', api, comic.vine, '&filter=name:', name, '&field_list=name,gender,id,birth,publisher,first_appeared_in_issue,count_of_issue_appearances,image&sort=count_of_issue_appearances:desc&format=json')
chosen.response <- GET(chosen.url)
chosen.body <- content(chosen.response, "text")
chosen.results <- fromJSON(chosen.body) 
data.chosen <- flatten(chosen.results$results)

# Information about the character chosen
character.id <- data.chosen$id
character.id <- character.id[1]

character <- paste0(url, 'character/4005-', character.id, api, comic.vine, '&format=json')
response.character <- GET(character)
body.character <- content(response.character, "text")
results.character <- fromJSON(body.character)
convert.all <- data.frame(t(sapply(results.character$results,c)))

# Get friends
convert.friends <- data.frame(t(sapply(convert.all$character_friends,c)))
get.friends <- data.frame(t(sapply(convert.friends$name,c)))

# Get powers
convert.powers <- data.frame(t(sapply(convert.all$powers,c)))
get.powers <- data.frame(t(sapply(convert.powers$name,c)))

# 

# Issue
issue <- data.chosen$first_appeared_in_issue.id
issue <- issue[1]
issue.url <- paste0(url, 'issue/4000-', issue, api, comic.vine, '&format=json')
response.issue <- GET(issue.url)
body.issue <- content(response.issue, "text")
results.issue <- fromJSON(body.issue)

data.issue <- data.frame(t(sapply(results.issue$results,c)))
issue.date <- data.frame(t(sapply(data.issue$cover_date,c))) # Gets the date when the character was first introduced

# Types
type <- paste0(url, 'types', api, comic.vine, '&format=json')
response.type <- GET(type)
body.type <- content(response.type, "text")
results.type <- fromJSON(body.type)
data.type <- flatten(results.type$results)

# Assumption made is that the character with the most appearances is the original character
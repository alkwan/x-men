library(jsonlite)
library(dplyr)
library(httr)

source('api-key.R')

base.uri <- "https://www.developer.marvel.com/v1"
resource <- "/public/characters"
full.url <- paste0(base.uri, resource)
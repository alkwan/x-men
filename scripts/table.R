library(httr)
library(jsonlite)

source('comic-vine.R')

female.chosen <- 'Wonder Woman'
ReturnInfoFemale <- function(female.chosen) {
  data.chosen.female <- CharacterAllInfo(female.chosen)
  date.female <- GetDate(data.chosen.female)
  appearances.female <- data.chosen.female$count_of_issue_appearances
  female.info <- data.frame(date.female[1], appearances.female[1])
  return(female.info)
}

ReturnInfoMale <- function(male.chosen) {
  data.chosen.male <- CharacterAllInfo(male.chosen)
  date.male <- GetDate(data.chosen.male)
  appearances.male <- data.chosen.male$count_of_issue_appearances
  male.info <- data.frame(date.male, appearances.male)
  return(male.info)
}

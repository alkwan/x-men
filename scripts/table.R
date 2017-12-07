library(httr)
library(jsonlite)

# Source comic-vine to get wrangled data
source('comic-vine.R')

# Gets the number of apperances for the female character that was chosen
ReturnInfoFemale <- function(female.chosen) {
  data.chosen.female <- CharacterAllInfo(female.chosen)
  date.female <- GetDate(data.chosen.female)
  appearances.female <- data.chosen.female$count_of_issue_appearances
  female.info <- data.frame(date.female[1], appearances.female[1])
  return(female.info)
}

# Gets the number of apperances for the male character that was chosen
ReturnInfoMale <- function(male.chosen) {
  data.chosen.male <- CharacterAllInfo(male.chosen)
  date.male <- GetDate(data.chosen.male)
  appearances.male <- data.chosen.male$count_of_issue_appearances
  male.info <- data.frame(date.male, appearances.male)
  return(male.info)
}

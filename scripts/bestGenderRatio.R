# Sorts the data into the 50 largest publishers, gets their character data,
# and orders it by highest female character ratio

library('dplyr')

bestGenderRatio <- function(data) {
  # Sort the data into gender counts
  gender.counts <- data %>%
    group_by(publisher.name) %>%
    count(gender) %>%
    filter(gender == 1 | gender == 2) %>%
    spread(gender, n)
  
  # Rename 1 and 2 as male and female, replace NA values with 0
  colnames(gender.counts) <- c("publisher.name", "male", "female")
  gender.counts <- replace(gender.counts, is.na(gender.counts), 0)
  
  # Get companies with more than 50 characters
  gender.counts <- gender.counts %>%
    mutate(total = male + female) %>%
    filter(total >= 50)
  
  # Get the gender ratios of these companies
  gender.ratios <- gender.counts %>%
    mutate(male.ratio = round(male / total * 100, digits = 2)) %>%
    mutate(female.ratio = round(female / total * 100, digits = 2)) %>%
    arrange(-total)
  
  # Choose the top 50 largest publishing companies and arrange by female character ratio
  top.publisher.ratios <- gender.ratios[1:50,] %>%
    arrange(-female.ratio)
  
  # Rename the columns to look nice
  colnames(top.publisher.ratios) <- c("Publisher", "Male Characters", "Female Characters",
                                      "Total Characters", "Percent Male", "Percent Female")
  
  return(top.publisher.ratios)
}
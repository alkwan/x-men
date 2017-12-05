# File to combine .csv files 

comicvine.data1 <- read.csv('comicvine_data1.csv', stringsAsFactors = FALSE)
comicvine.data2 <- read.csv('comicvine_data2.csv', stringsAsFactors = FALSE)
comicvine.data3 <- read.csv('comicvine_data3.csv', stringsAsFactors = FALSE)

comicvine.data <- rbind(comicvine.data1, comicvine.data2, comicvine.data3)
# x-men

Check out our app [https://alkwan.shinyapps.io/genderincomics](https://alkwan.shinyapps.io/genderincomics)!

## Overview
The comic book industry is often thought of as a boys club, but it's 2017 and feminism seems to be on the rise. Gender equality initiatives seem to be happening all over the STEM field, but is it happening in comics? To find out, we looked at Comic Vine 's API. Our goal with this project is to see if there are any disparities between gender when it comes to comic book characters. If there are, where do they appear?

## Data
We sorted through Comic Vine's extensive comic book character data, getting over 100,000 results to analyze. We've chosen to visualize the data in the following ways: a side by side character comparison chart (male vs female), a bar chart showing the number of female and male characters per publisher (and comparing the two), and a table showing the 50 largest publishers sorted by best female to male gender ratio.

## Audience 
We believe that comics should be inclusive and for everyone. We hope to reach and encourage any girls who wonder if they, too, have a place in comic book fandom. We also hope to reach publishers and creators to show that, even in 2017, gender equity is still lacking.

## Challenges
We encountered many challenges in creating our Shiny app. One major challenge was handling the result cap for the Comicvine API (the results were capped at one hundred results so we could only get a dataframe of one hundred comic book characters at a time). To work around that, we created a function that looped through the API and built a dataframe of character data 100 results at a time (which took a couple of hours). We then wrote the dataframe into a .csv file so that the data would be easily accessible. Another major challenge we faced was the connection to the API. The API actually stopped working a few times so we did not get to implement all the features we wanted to in our app.

## Creators
* Alaina Kwan 
* Omar Azeemi
* Sylvia Wu
* Michelle Gouw
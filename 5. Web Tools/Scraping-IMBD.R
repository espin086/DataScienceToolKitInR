
library(dplyr)
library(pbapply)
library(omdbapi)

#Reading in data with list of movies to examine
#setwd("~/Desktop")
all.movies <- read.csv("regressionraw_2016_03_w_HV v2.csv", stringsAsFactors = FALSE)
all.movies <- all.movies[order(- all.movies$WW.Box),] 

#Recoding titles to conform to IMDB title
all.movies$Film.Title[all.movies$Film.Title == "Furious Seven"] <- "Furious 7"
all.movies$Film.Title[all.movies$Film.Title == "Iron Man Three"] <- "Iron Man 3"

#Recoding titles to conform to IMDB title
our.movies <- head(all.movies, n = 20)
titles <- as.vector(our.movies$Film.Title)

#Searching for potential titles and saving IMBD ID numbers
#titles <- list("Captain America", "Terminator")
potential.titles <- lapply(titles, search_by_title)

imbd.id <- list()
for (i in 1:length(potential.titles)){
        imbd.id[[i]] <- potential.titles[[i]][[3]]
        }

imbd.id <- unlist(imbd.id)
imbd.id <- unique(imbd.id)

#Feeding IMBD ID Numbers into function that will find movie info
title.info <- lapply(imbd.id, find_by_id)
df <- data.frame(matrix(unlist(title.info), nrow = length(title.info), byrow=T))

names(df) <- c( "Title",
"Year",
"Rated",
"Released",
"Runtime",
"Genre",
"Director",
"Writer",
"Actors",
"Plot",
"Language",
"Country",
"Awards",
"Poster",
"Metascore",
"imdbRating",
"imdbVotes",
"imdbID",
"Type")

write.csv(df, "OMDB Scraping Example.csv")

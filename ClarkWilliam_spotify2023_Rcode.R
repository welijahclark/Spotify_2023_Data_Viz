#ClarkWilliam-STA5166-Quiz1 R Script

#Clearing Out Lists
rm(list=ls())

#Packages installed (Note: Also added the ggdark theme for personal preference.)
#install.packages("readr")
library(readr)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("devtools")
library(devtools)
devtools::install_github("nsgrantham/ggdark")
library(ggdark)

#Import Data
spotify_2023 <- read_csv("All Academic Files/All Graduate Dox/Grad School Course Files/Statistics in Applications 1/Extra Credit Project 1/Datasets/spotify-2023.csv")

#Step 2: Declaring Variables + Light Pre-processing
#Note: I think the dataset variable "streams" is quite large, so I'm going to do a log transform
#Note 2: Streams also got recorded as character data for some reason...
spotify_2023$streams <- as.numeric(spotify_2023$streams)
na.omit(spotify_2023$streams)
log_streams <- log(spotify_2023$streams)
splaylist_count <- spotify_2023$in_spotify_playlists
log_splaylist <- log(splaylist_count)
song_key <- spotify_2023$key
song_mode <- spotify_2023$mode
release_year <- spotify_2023$released_year

#Step 3: Time to make some graphs!

#Scatterplots of streams to in_spotify_playlists
ggplot(spotify_2023, aes(streams, splaylist_count)) + geom_point(color="#191414", fill="#1DB954", shape=21) + labs(title= "Scatterplot of Stream Count to Playlist Count", subtitle = "(raw numbers)", x="Number of Streams", y="Number of Playlist Appearances") + dark_theme_grey()

ggplot(spotify_2023, aes(log_streams, log_splaylist)) + geom_point(color="#191414",fill="#1DB954", shape=21) + labs(title= "Scatterplot of Stream Count to Playlist Count", subtitle = "(log transformed numbers)", x="Log Number of Streams", y="Log Number of Playlist Appearances") + dark_theme_grey()

#Simple Linear Regression Graphs of streams to in_spotify_playlists
ggplot(spotify_2023, aes(streams, splaylist_count)) + geom_point(color="#191414", fill="#1DB954", shape=21) + labs(title= "Simple Regression of Stream Count to Playlist Count", subtitle = "(raw numbers)", x="Number of Streams", y="Number of Playlist Appearances") + geom_smooth(color="#FFFFFF", method = "lm") + dark_theme_grey()

ggplot(spotify_2023, aes(log_streams, log_splaylist)) + geom_point(color="#191414",fill="#1DB954", shape=21) + labs(title= "Simple Regression of Stream Count to Playlist Count", subtitle = "(log transformed numbers)", x="Log Number of Streams", y="Log Number of Playlist Appearances") + geom_smooth(color="#FFFFFF", method = "lm") + dark_theme_gray()

#ANOVA graph of streams to song keys
ggplot(spotify_2023, aes(song_key, log_streams)) + geom_boxplot(fill="#1DB954", color="#FFFFFF") + labs(title="ANOVA of Song Key to Spotify Streams", x="Song Key", y="Number of streams (log transform)") + dark_theme_gray()

#ANOVA graph of streams to Minor/Major mode
ggplot(spotify_2023, aes(song_mode, log_streams)) + geom_boxplot(fill="#1DB954", color="#FFFFFF") + labs(title="ANOVA of Song Mode to Spotify Streams", x="Song Key", y="Number of streams (log transform)") + dark_theme_gray()

#Stacked Kernel Densities of Song Streams by Song Key
ggplot(spotify_2023, aes(x = log_streams, color = song_key))+ geom_density(alpha = .05, position = "stack") + labs(title="Stacked Kernel Densities of Streams by Song Key", x="Number of streams (log transform)") + dark_theme_gray()

#Songs by release year
ggplot(spotify_2023, aes(x=release_year)) + geom_histogram(binwidth=5, fill="#1DB954") + labs(title="Number of Songs by Release Year", x="Release Year") + dark_theme_gray()


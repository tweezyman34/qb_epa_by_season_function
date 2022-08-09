#Install those packages
library(tidyverse)
library(nflfastR)
library(data.table)
install.packages("plyr")
install.packages("questionr")
library(questionr)
library(plyr)

#load pbp data from nflfastR from 2018-2021 and make it a data table
pbp <- load_pbp(2018:2021)
pbp <- data.table(pbp)

#Filter out all instances where a pass was not thrown
passer <- pbp %>%
  filter(passer_player_name != "NA")

#Test with random player
passer[passer_player_name == "B.Mayfield"]

#Create function to find epa by season for a given player
qb_epa <- function(player) {
  
  data_player <- passer[passer_player_name == player]
  
  data_epa <- aggregate(data_player$epa, by = list(data_player$season),
                        sum)
  
  data_return <- data.table(player = player,
                            season = data_epa$Group.1,
                            epa = data_epa$x)
  return(data_return)
}

#Get epa per season from 2018
qb_epa("S.Darnold")
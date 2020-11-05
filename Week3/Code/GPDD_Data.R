#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: GPDD_Data.R
# Description: script that creates a map of the Global Population Dynamics Database (GPDD)
# Input: Rscript GPDD_Data.R
# Output: none
# Arguments:0
# Date: October 2020

#load maps and ggplot
library(maps)
library(ggplot2)

#load GPDD_Data.R
data_set <- get(load("../Data/GPDDFiltered.RData"))

#create a world map
map(database="world")

#turn data from maps package into a dataframe suitable for ggplot2
world <- map_data("world")

#ggplot2 to plot data_set long and lat
GPDD_map <- ggplot()+ 
    labs(title="Global Population Dynamics Database (GPDD)", x="longitude", y="latitude")+
    geom_map(data=world, map=world, aes(map_id=region), fill="gray98", colour="black") +
    geom_point(data=data_set, aes(x=long, y=lat), size=1, shape=23, fill="red3")

GPDD_map

#any analysis based on the data available from the GPDD will be biased towards species present in the Northern Emisphere, especially the UK, Europe and Northern America.
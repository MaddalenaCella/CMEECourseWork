#!/bin/env R

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: GrowthData.R
#
# Description: script that identifies growth curves for model fitting
#
# Arguments: 0
#
# Input: Rscript GrowthData.R
#
# Output: two *.csv files in ../Data subdirectory
#
# Date: January 2021

rm(list=ls())

#required packages
suppressPackageStartupMessages(library(tidyverse))
library(dplyr, warn.conflicts = FALSE)

# Suppress summarise info
options(dplyr.summarise.inform = FALSE)

##data exploration
data<- read.csv("../Data/LogisticGrowthData.csv") 
metadata<- read.csv("../Data/LogisticGrowthMetaData.csv")

#remove rows with a negative time-->assume that measurement starts at time 0
data <- data[!(data$Time < 0),]
#remove rows with a negative pop size-->assume that pop cannot drop below zero
data <- data[!(data$PopBio < 0),]

#now remove the known psychrophiles from the data
data <- data[!(data$Species == 'Arthrobacter sp. 77'),]
data <- data[!(data$Species == 'Arthrobacter sp. 62'),]
data <- data[!(data$Species == 'Arthrobacter sp. 88'),]
data <- data[!(data$Species == 'Pseudomonas sp.'),]
data <- data[!(data$Species == 'Aerobic Psychotropic.'),]

#I will also remove the spoilage flora as it's exact bacterial comp is not known
data <- data[!(data$Species == 'Spoilage'),]

#data:remove all =D_595 because it is a very different unit
data <- data[!(data$PopBio_units == 'OD_595'),]

data$ID <- paste(data$Species,"_", data$Temp, "_",data$Medium, "_",data$Citation)

#create an id column where every unique id has a number
data <-within(data, num_id <- match(ID, unique(ID)))

#to avoid generating -inf when taking the log of PopBio, I will add 0.1 to all the column PopBio
for (i in 1:length(data$PopBio)){
        data$PopBio[i] <- data$PopBio[i]+0.1
}

data$LogN <- log(abs(data$PopBio))
LogN <- data$LogN

data_above15<- data %>% group_by(Temp) %>% 
filter(Temp>=15)

data_below15<-data %>% group_by(Temp) %>% 
filter(Temp<15)

#id 42 is a super small group (just 4 data points, remove)--> it generates inf below in cubic so better removing it
#remove subset smaller than 5 because of the non-linear models number of parametrs
data_above15 <- data_above15 %>% group_by(num_id)%>%
filter(n()>5)
#65

data_below15 <- data_below15 %>% group_by(num_id, Species)%>%
filter(n()>5)#to avoid underparameterise the data in the cubc--> you finish your dfs with a dataset smaller than 4, we actually fileter by 5 because of dfs in non-linear models
#69

#export tidy datasets as csv
write.csv(data_above15, "../Data/tidy_above15.csv", row.names=TRUE)
write.csv(data_below15, "../Data/tidy_below15.csv", row.names=TRUE)




#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: PP_Dists.R
# Description: script that draws and saves three figures, containing subplots of distributions of predator mass, prey mass, 
# and the size ratio of prey mass over predator mass by feeding interaction type and a summary csv file
# Input: Rscript PP_Dists.R
# Output: 3 plots (Pred_Subplots.pdf, Prey_Subplots.pdf, SizeRatio_Subplots.pdf) in Results directory and a csv file (PP_Results.csv) in Results directory
# Arguments:0
# Date: October 2020

require(tidyverse)
library(ggplot2)
library(dplyr)

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded
head(MyDF)

dplyr::glimpse(MyDF)

MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)
str(MyDF)

#each containing subplots of distributions of predator mass, prey mass, 
#and the size ratio of prey mass over predator mass by feeding interaction type
pdf("../Results/Pred_Subplots.pdf", # Open blank pdf page using a relative path
    11.7, 8.3)
par(mfcol=c(2,3)) #initialize multi-paneled plot
par(mfg = c(1,1))


#for each feeding type do a body mass distribution for predator
MyDF.I <- subset(MyDF, Type.of.feeding.interaction=='insectivorous')

hist(log10(MyDF.I$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.2, 0.8, 0.9, 1), # Note 'rgb', fourth value is transparency
    main = "Insectivorous size")

MyDF.P <- subset(MyDF, Type.of.feeding.interaction=='piscivorous')

hist(log10(MyDF.P$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.3, 0.6, 0.5, 1), # Note 'rgb', fourth value is transparency
    main = "Piscivorous size")

MyDF.PL <- subset(MyDF, Type.of.feeding.interaction=='planktivorous')

hist(log10(MyDF.PL$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.4, 0.5, 0, 1), # Note 'rgb', fourth value is transparency
    main = "Planktivorous size")

MyDF.PR <- subset(MyDF, Type.of.feeding.interaction=='predacious')

hist(log10(MyDF.PR$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.5, 0.5, 0.5, 1), # Note 'rgb', fourth value is transparency
    main = "Predacious size")

MyDF.PP <- subset(MyDF, Type.of.feeding.interaction=='predacious/piscivorous')

hist(log10(MyDF.PP$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.7, 0.5, 0, 1), # Note 'rgb', fourth value is transparency
    main = "Predacious/piscivorous size")

dev.off()

#for each feeding type do a body size distribution prey
pdf("../Results/Prey_Subplots.pdf", # Open blank pdf page using a relative path
    11.7, 8.3)
par(mfcol=c(2,3)) #initialize multi-paneled plot
par(mfg = c(1,1))

hist(log10(MyDF.I$Prey.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.2, 0.8, 0.9, 1), # Note 'rgb', fourth value is transparency
    main = "Insectivorous size")

hist(log10(MyDF.P$Prey.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.3, 0.6, 0.5, 1), # Note 'rgb', fourth value is transparency
    main = "Piscivorous size")

hist(log10(MyDF.PL$Prey.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.4, 0.5, 0, 1), # Note 'rgb', fourth value is transparency
    main = "Planktivorous size")

hist(log10(MyDF.PR$Prey.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.5, 0.5, 0.5, 1), # Note 'rgb', fourth value is transparency
    main = "Predacious size")

hist(log10(MyDF.PP$Prey.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.7, 0.5, 0, 1), # Note 'rgb', fourth value is transparency
    main = "Predacious/piscivorous size")

dev.off()

#sizeratio subplots (prey mass over predator mass)
pdf("../Results/SizeRatio_Subplots.pdf", # Open blank pdf page using a relative path
    11.7, 8.3)
par(mfcol=c(2,3)) #initialize multi-paneled plot
par(mfg = c(1,1))

hist(log10(MyDF.I$Prey.mass/MyDF.I$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.2, 0.8, 0.9, 1), # Note 'rgb', fourth value is transparency
    main = "Insectivorous size")

hist(log10(MyDF.P$Prey.mass/MyDF.P$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.3, 0.6, 0.5, 1), # Note 'rgb', fourth value is transparency
    main = "Piscivorous size")

hist(log10(MyDF.PL$Prey.mass/MyDF.PL$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.4, 0.5, 0, 1), # Note 'rgb', fourth value is transparency
    main = "Planktivorous size")

hist(log10(MyDF.PR$Prey.mass/MyDF.PR$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.5, 0.5, 0.5, 1), # Note 'rgb', fourth value is transparency
    main = "Predacious size")

hist(log10(MyDF.PP$Prey.mass/MyDF.PP$Predator.mass), xlab="log10(Body Mass (g))", ylab="Count", 
    col = rgb(0.7, 0.5, 0, 1), # Note 'rgb', fourth value is transparency
    main = "Predacious/piscivorous size")

dev.off()

#csv file output

#use dplyr: first hroup by feeding interaction and then summarise the data with summarise()
Summary <- MyDF %>% group_by(Type.of.feeding.interaction) %>% 
summarise(
        Predator.mass.log.mean= mean(log(Predator.mass)),
        Predator.mass.log.median= median(log(Predator.mass)),
        Prey.mass.log.mean= mean(log(Prey.mass)),
        Prey.mass.log.median= median(log(Predator.mass)),
        Pred.Prey.log.mass.mean= mean(log(Prey.mass/Predator.mass)),
        Pred.Prey.log.mass.median= median(log(Prey.mass/Predator.mass))
    )
#write output of the summary on a csv file
write.csv(Summary, "../Results/PP_Results.csv")



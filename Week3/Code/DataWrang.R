#!/bin/env Rscript
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: DataWrang.R
# Description: Data wrangling exercise
# Input: Rscript DataWrang.R
# Output: some tibbles
# Arguments: 0
# Date: October 2020

MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = FALSE))
class(MyData)

#loading the metadata
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = TRUE,  sep=";")
class(MyMetaData)

head(MyData)

head(MyMetaData)

#All blank cells in the data are true absences, 
#in the sense that species was actually not present in that quadrat. So we can replace those blanks with zero
MyData[MyData == ""] = 0

MyData <- t(MyData) 
head(MyData)

colnames(MyData)

#first create a temporary dataframe with just the data, without the column names
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
head(TempData)

colnames(TempData) <- MyData[1,] # assign column names from original data
head(TempData)

rownames(TempData) <- NULL
head(TempData)

require(reshape2)# load the reshape2 package

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
head(MyWrangledData); tail(MyWrangledData)

MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])
str(MyWrangledData)

tidyverse_packages(include_self = TRUE) # the include_self = TRUE means list "tidyverse" as well 

require(tidyverse)

#let’s convert the dataframe to a “tibble
tibble::as_tibble(MyWrangledData) 

dplyr::glimpse(MyWrangledData) #like str(), but nicer!

dplyr::filter(MyWrangledData, Count>100) #like subset(), but nicer!

dplyr::slice(MyWrangledData, 10:15) # Look at an arbitrary set of data rows


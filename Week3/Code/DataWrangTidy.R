#!/bin/env Rscript
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: DataWrangTidy.R
# Description: Data wrangling using tidyverse
# Input: Rscript DataWrangTidy.R
# Output: some tibbles
# Arguments: 0
# Date: October 2020

library(tidyverse)
library(tidyr)
library(dplyr)

rm(list=ls())
MyData <- as.matrix(read.csv("../Data/PoundHillData.csv",header = FALSE))
class(MyData)

#loading the metadata
MyMetaData <- read.csv("../Data/PoundHillMetaData.csv",header = TRUE,  sep=";")
class(MyMetaData)

tibble::as_tibble(MyData) #corresponds to head()

#All blank cells in the data are true absences, 
#in the sense that species was actually not present in that quadrat. So we can replace those blanks with zero
MyData[MyData == ""] = 0

#convert long to wide format 

MyData <- t(MyData) 
head(MyData)

#first create a temporary dataframe with just the data, without the column names
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
tibble::as_tibble(TempData)

colnames(TempData) <- MyData[1,] # assign column names from original data
tibble::as_tibble(TempData)

rownames(TempData) <- NULL
tibble::as_tibble(TempData)

MyWrangledData <- gather(TempData, "Species", "Count", 5:dim(TempData)[2]) #dim() gives number of columns and number of rows

tibble::as_tibble(MyWrangledData) 
tibble::as_tibble(MyWrangledData[(dim(MyWrangledData)[1]-5):dim(MyWrangledData)[1],]) #like tail()

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


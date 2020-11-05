#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: basic_io.R
# Description: input and output files
# Input: Rscript basic_io.R
# Output: file named MyData.csv in Results
# Arguments:0
# Date: October 2020

# A simple script to illustrate R input-output.  
# Run line by line and check inputs outputs to understand what is happening  

MyData <- read.csv("../Data/trees.csv", header = TRUE) # import with headers

write.csv(MyData, "../Results/MyData.csv") #write it out as a new file

write.table(MyData[1,], file = "../Results/MyData.csv",append=TRUE) # Append to it

write.csv(MyData, "../Results/MyData.csv", row.names=TRUE) # write row names

write.table(MyData, "../Results/MyData.csv", col.names=FALSE) # ignore column names

print("Script complete")


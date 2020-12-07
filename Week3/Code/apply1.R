#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: apply1.R
# Description: script that shows the use of apply() function
# Input: Rscript apply1.R
# Output: mean and variance for each row of a matrix and mean for each column of the matrix
# Arguments:0
# Date: October 2020

## Build a random matrix
M <- matrix(rnorm(100), 10, 10) #rnorm() draw 100 random numbers
#and store them in a 10x10 matrix

## Take the mean of each row
RowMeans <- apply(M, 1, mean) #calculate the mean of each row (1)
print (RowMeans)

## Now the variance
RowVars <- apply(M, 1, var)
print (RowVars)

## By column (2)
ColMeans <- apply(M, 2, mean)
print (ColMeans)
#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: next.R
# Description: use of 'next' in for loop
# Input: Rscript next.R
# Output: odd numbers from 1 to 10
# Arguments:0
# Date: October 2020

#how to skip to the next iteration loop using 'next'

for (i in 1:10) {
  if ((i %% 2) == 0) # check if the number is odd
    next # pass to next iteration of loop 
  print(i)
}
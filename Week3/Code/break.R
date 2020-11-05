#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: break.R
# Description: test breakpoints in while loop
# Input: Rscript break.R
# Output: output of while loop
# Arguments:0
# Date: October 2020

i <- 0 #Initialize i
    while(i < Inf) {
        if (i == 10) {
            break 
             } # Break out of the while loop! 
        else { 
            cat("i equals " , i , " \n")
            i <- i + 1 # Update i
    }
}
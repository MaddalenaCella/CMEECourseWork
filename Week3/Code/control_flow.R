#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: control_flow.R
# Description: examples of conditional and for loops
# Input: Rscript control_flow.R
# Output: outcomes of conditional and for loops
# Arguments:0
# Date: October 2020

a <- TRUE
if (a == TRUE){
    print ("a is TRUE")
    } else {
    print ("a is FALSE")
}

z <- runif(1) ## Generate a uniformly distributed random number
if (z <= 0.5) {print ("Less than a half")}

for (i in 1:10){
    j <- i * i
    print(paste(i, " squared is", j ))
}

for(species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')){
  print(paste('The species is', species))
}
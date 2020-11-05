#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: preallocate.R
# Description: script containing examples of of two blocks of code showing how preallocation works and how it saves memory space
# Input: Rscript preallocate.R
# Output: scripts running times with and without preallocation
# Arguments:0
# Date: October 2020

#script containing examples of of two blocks of code showing how preallocation works and how it saves memory space

NoPreallocFun <- function(x){
#function contaning loop without preallocation
    a <- vector()
    for (i in 1:10) {
    a <- c(a, i)
    print(a)
    print(object.size(a))
}
}

system.time(NoPreallocFun(10))

PreAllocFun <- function(x){
#function containing loop with preallocation
a <- rep(NA, 10)
for (i in 1:10) {
    a[i] <- i
    print(a)
    print(object.size(a))
}
}

system.time(PreAllocFun(10))
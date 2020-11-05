#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: apply2.R
# Description: try apply with self-designed function
# Input: Rscript apply2.R
# Output: matrix with result of function operation
# Arguments:0
# Date: October 2020

SomeOperation <- function(v){ # (What does this function do?)
  if (sum(v) > 0){ #note that sum(v) is a single (scalar) value
    return (v * 100)
  }
  return (v)
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))

#the function SomeOperation takes as input v. 
#Then if the sum of v is greater than zero, it multiplies that value by 100. 
#So if v has positive and negative numbers, and the sum comes out to be positive, 
#only then does it multiply all the values in v by 100 and return them.
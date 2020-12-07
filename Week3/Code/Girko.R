#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: Girko.R
# Description: plot Girko law simulation
# Input: Rscript Girko.R
# Output: plot in results directory named Girko.pdf
# Arguments:0
# Date: October 2020

library(ggplot2)

build_ellipse <- function(hradius, vradius){ # function that returns an ellipse
  npoints = 250
  a <- seq(0, 2 * pi, length = npoints + 1)
  x <- hradius * cos(a)
  y <- vradius * sin(a)  
  return(data.frame(x = x, y = y))
}

N <- 250 # Assign size of the matrix

M <- matrix(rnorm(N * N), N, N) # Build the matrix

eigvals <- eigen(M)$values # Find the eigenvalues

eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals)) # Build a dataframe

my_radius <- sqrt(N) # The radius of the circle is sqrt(N)

ellDF <- build_ellipse(my_radius, my_radius) # Dataframe to plot the ellipse

names(ellDF) <- c("Real", "Imaginary") # rename the columns

pdf("../Results/Girko.pdf", # Open blank pdf page using a relative path
    11.7, 8.3)
# plot the eigenvalues
ggplot(eigDF, aes(x = Real, y = Imaginary))+
    geom_point(shape = I(3)) + theme(legend.position = "none")+
    geom_hline(aes(yintercept = 0))+ geom_vline(aes(xintercept = 0)) +
    geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, alpha = 1/20, fill = "red"))
dev.off()
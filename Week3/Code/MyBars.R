#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: MyBars.R
# Description: annotates plots with labels
# Input: Rscript MyBars.R
# Output: plot in results directory named MyBars.pdf
# Arguments:0
# Date: October 2020

library(ggplot2)

a <- read.table("../Data/Results.txt", header = TRUE)
head(a)

a$ymin <- rep(0, dim(a)[1]) # append a column of zeros

# Print the first linerange
pdf("../Results/MyBars.pdf", # Open blank pdf page using a relative path
    11.7, 8.3)
ggplot(a) + 
  geom_linerange(data = a, aes(x = x,  ymin = ymin, ymax = y1, size = (0.5)), colour = "#E69F00", alpha = 1/2, show.legend = FALSE) +
  geom_linerange(data = a, aes(x = x, ymin = ymin, ymax = y2, size = (0.5)),colour = "#56B4E9", alpha = 1/2, show.legend = FALSE) + 
  geom_linerange(data = a, aes(x = x,ymin = ymin,ymax = y3,size = (0.5)),colour = "#D55E00",alpha = 1/2, show.legend = FALSE)+
  geom_text(data = a, aes(x = x, y = -500, label = Label))+
  scale_x_continuous("My x axis",breaks = seq(3, 5, by = 0.05)) + scale_y_continuous("My y axis") + theme_bw() + theme(legend.position = "none") 
dev.off()

# This script calculates the tree height for all trees in the trees.csv data set using the trigonometric formula:
# height = distance * tan(radians) and stores sthe results in a .csv output file
#
# ARGUMENTS
# None
#
# INPUT
# trees.csv downloaded from https://raw.githubusercontent.com/mhasoba/TheMulQuaBio/master/content/data/trees.csv
# and stored in the ../data/ directory
#
# OUTPUT
# TreeHts.csv stored in ../results/ directory containing an additional column (with respect to trees.csv)
# where the results of the tree height calculation gets stored.

#input
Trees <- read.csv("../Data/trees.csv", header = TRUE)

# function that calculates heights of trees given distance of each tree from its base and angle to its top
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance){
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    return (height)
}

#add a new column to the dataframe where the tree height is stored
Trees$TreeHeight.m <- TreeHeight(Trees$Angle.degrees, Trees$Distance.m)

head(Trees) #check the first few lines of the data frame

#output
write.csv(Trees, "../Results/TreeHts.csv")

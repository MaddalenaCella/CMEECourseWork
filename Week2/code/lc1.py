#!/usr/bin/env python3

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: lc1.py
# Description: python list comprehension exercise
# Date: October 2020

""" Python list comprehensions 1 """
__appname__="lc1.py"
__author__="Maddalena Cella mc2820@ic.ac.uk"
__version__="0.0.1"
__license__="None"

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

BirdLatin = [(birds [0] [0]), (birds [1] [0]), (birds [2] [0]), (birds [3] [0]), (birds [4] [0])]
print ("The latin names of the bird species are:", BirdLatin)

BirdCommon = [(birds [0] [1]), (birds [1] [1]), (birds [2] [1]), (birds [3] [1]), (birds [4] [1])]
print ("The common names of the previously listed bird species are:", BirdCommon)

BirdMass = [(birds [0] [2]), (birds [1] [2]), (birds [2] [2]), (birds [3] [2]), (birds [4] [2])]
print ("The mean body mass for each birdspecies is:", BirdMass)


# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
BirdLatin = []
BirdCommon = []
BirdMass = []

for l, c, m in birds:
    BirdLatin.append(l)
    BirdMass.append(m)
    BirdCommon.append(c)
    
print ("The latin names of the bird species are:", BirdLatin)
print ("The common names of the previously listed bird species are:", BirdCommon)
print ("The mean body mass for each birdspecies is:", BirdMass)

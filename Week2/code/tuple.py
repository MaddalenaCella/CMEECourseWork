#!/usr/bin/env python3

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: tuple.py
# Description: python list comprehension exercise
# Date: October 2020

""" Python list comprehensions 3 """
__appname__="tuple.py"
__author__="Maddalena Cella mc2820@ic.ac.uk"
__version__="0.0.1"
__license__="None"

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

for line in birds:
    print("Latin name:", line[0], "\n", "Common name:", line[1], "\n", "Average weigth:", line[2], "\n")

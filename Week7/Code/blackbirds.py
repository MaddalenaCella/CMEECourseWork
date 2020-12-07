#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: blackbirds.py
#
# Description: Regular expressions in Python exercise
#
# Arguments: 0
#
# Input: python3 blackbirds.py
#
# Output: captured Kingdom, Phylum and Species from blackbirds.txt
#
# Date: November 2020

""" Script that uses regualar expressions to extract taxonomic hierarchy of some birds in a text file"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'regexes.py'
__version__ = '0.0.1'
__license__= 'None'

import re
import numpy as np

# Read the file (using a different, more python 3 way, just for fun!)
with open('../Data/blackbirds.txt', 'r') as f:
    text = f.read()

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')

text= re.sub(r'\s+',' ',text) #.strip()#substitute the multiple whitespaces with one single one
#re.sub(pattern, replace, string)

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

# Now extend this script so that it captures the Kingdom, Phylum and Species
# name for each species and prints it out to screen neatly.

texts = re.findall(r'Kingdom [A-Za-z]*|Phylum [A-Za-z]*|Species [A-Za-z]* [a-z]*', text) 
texts=np.matrix(texts)
texts= texts.reshape((4,3)) #reshape the numpy matrix with 4 rows and 3 columns
texts= texts.tolist() #convert the numpy array into a list of lists
for ls in texts[:][0:4]:
    print(ls) #print every list in the list of lists

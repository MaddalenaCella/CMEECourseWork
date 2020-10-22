#!/usr/bin/env python3

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: lc2.py
# Description: python list comprehension exercise
# Date: October 2020

""" Python list comprehensions 2 """
__appname__="lc2.py"
__author__="Maddalena Cella mc2820@ic.ac.uk"
__version__="0.0.1"
__license__="None"

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
)

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
over100 = [rainfall[line][:] for line in range(len(rainfall)) if rainfall[line][1] > 100]
print (over100)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 
less50 = [rainfall[line][:] for line in range(len(rainfall)) if rainfall[line][1] < 50]
print (less50)

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !)

over100 = []
for line in rainfall:
    if line[1] > 100 : #and both[1] not in over100:
        over100.append(line) #index out of range problem
print (over100)

less50 = []
for line in rainfall:
    if line[1] < 50 :
        less50.append(line)
print (less50)

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

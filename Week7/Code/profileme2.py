#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: profileme2.py
#
# Description: modeified profileme.py with list comprehesions and explicit string concatenation to speed up running time
#
# Arguments: 0
#
# Input: python3 profileme2.py
#
# Output: terminal output on code running time
#
# Date: November 2020

""" Script with vectorised functions"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'profileme2.py'
__version__ = '0.0.1'
__license__= 'None'

import numpy as np

def my_squares(iters):
    """function that takes the square of every input value and appends the results"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """function that joins textstrings and appends the result"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """function that runs the previously defined functions and returns 0 when it has finished"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")
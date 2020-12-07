#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: profileme.py
#
# Description: script with functions with no vectorisation
#
# Arguments: 0
#
# Input: python3 profileme.py
#
# Output: terminal output on code running time
#
# Date: November 2020

""" Script with non-vectorised functions"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'profileme.py'
__version__ = '0.0.1'
__license__= 'None'

def my_squares(iters):
    """function that takes the square of every input value and appends the results"""
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """function that joins textstrings and appends the result"""
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    """function that runs the previously defined functions and returns 0 when it has finished"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")
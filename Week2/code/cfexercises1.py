#!/usr/bin/env python3

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: cfexercises1.py
# Description: python writing program with control flows
# Date: October 2020

""" Modify python code to make it a program """
__appname__="cfexercises1.py"
__author__="Maddalena Cella mc2820@ic.ac.uk"
__version__="0.0.1"
__license__="None"


import sys

def foo_1(x):
""" a function that returns the power of 0.5 of any x inputed"""
    return x ** 0.5

def foo_2(x, y):
""" a function that returns the biggest value out of two that get inputed """
    if x > y:
        return x
    return y

def foo_3(x, y, z):
""" a function that stops when z is the smallest value """
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
""" a function that returns the product of the numbers in the range from 1 to any x plus 1 """
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

#the factorial is the product of all positive integers less then or equal to n [n * (n-1) * (n-2) * ...]
def foo_5(x): 
""" a recursive function that calculates the factorial of x """
    if x == 1:
        return 1
    return x * foo_5(x - 1)
  
def foo_6(x): 
""" a function that calculates the factorial of x in a different way """  
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

""" make foo_x a program that evaluates all the foo_x functions """
def main(argv):
    print(foo_1(3))
    print(foo_2(4, 3))
    print(foo_3(4, 3, 2))
    print(foo_4(2))
    print(foo_5(6))
    print(foo_6(6))
    return 0

if __name__ == "__main__": 
    status = main(sys.argv) 
    sys.exit(status)

#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: TestR.py
#
# Description: this script shows how to run Rscript within Python
#
# Arguments: 0
#
# Input: python3 TestR.py
#
# Output: terminal output of content of TestR.R
#
# Date: November 2020

""" Script that runs TestR.R within Python"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'TestR.py'
__version__ = '0.0.1'
__license__= 'None'


import subprocess
subprocess.Popen("Rscript --verbose TestR.R > ../Results/TestR.Rout 3> ../Results/TestR_errFile.Rout", shell=True).wait()


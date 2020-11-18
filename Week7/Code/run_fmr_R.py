#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: run_fmr_R.py
#
# Description: this script runs an Rscript with Python using the package subprocess
#
# Arguments: 0
#
# Input: python3 run_fmr_R.py
#
# Output: shell output of whether the run was successful, and the contents of the R console output
#
# Date: November 2020

""" Script that runs an Rscript with Python using the package subprocess"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'run_fmr_R.py'
__version__ = '0.0.1'
__license__= 'None'

import subprocess

p= subprocess.Popen("Rscript --verbose fmR.R 2> ../Results/fmr.R", shell=True).wait()

if p==0:
    print("Python run was successful!")
else:
    print("Python run was unsuccessful!")


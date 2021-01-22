#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: run_LV.py
#
# Description: this script runs and profiles Lotka_Volterra models
#
# Arguments: 0
#
# Input: python3 run_LV.py
#
# Output: 
#
# Date: November 2020

""" Script that plots Lotka-Volterra model with input model parameters from command line"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'run_LV.py'
__version__ = '0.0.1'
__license__= 'None'

import cProfile

#run LV* for profiling
import LV1
cProfile.run('LV1.LV()', sort="tottime")

import LV2
cProfile.run('LV2.LV()', sort="tottime")

import LV3
cProfile.run('LV3.main()', sort='tottime')

import LV4
cProfile.run('LV4.main()', sort='tottime')


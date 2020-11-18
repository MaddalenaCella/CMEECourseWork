#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: LV2.py
#
# Description: this script plots the Lotka-Volterra model in two graphs
#
# Arguments: 0
#
# Input: python3 LV2.py arg1 arg2 ... etc
#
# Output: one pdf file containing two plots in ../Results/ directory and the final population sizes of consumers and resources
#
# Date: November 2020

""" Script that plots Lotka-Volterra model with input model parameters from command line"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'LV2.py'
__version__ = '0.0.1'
__license__= 'None'

#packages needed
import sys
import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
from matplotlib.backends.backend_pdf import PdfPages

def LV():
    """define function for cProfile"""
    def dCR_dt(pops, t=0):
        """a function that returns the growth rate of consumer and resource population at any given time step"""

        R = pops[0]
        C = pops[1]
        K= 28

        dRdt = r * R * (1- R/K) - a * R * C 
        dCdt = -z * C + e * a * R * C
    
        return np.array([dRdt, dCdt])

        #assign parameter values
    if len(sys.argv) <5:
        print("You have not inputed the model parameters... Using defaults values")
        r=1
        a=0.1
        z=1.5
        e=0.75
    else:
        print("Applying the LV mode with the inputed parameters")
        r = float(sys.argv[1]) #1
        a = float(sys.argv[2]) #0.1
        z = float(sys.argv[3]) #1.5
        e = float(sys.argv[4]) #0.75

#Define the time vector; let’s integrate from time point 0 to 15, using 1000 sub-divisions of time
    t = np.linspace(0, 30, 1000)

#Set the initial conditions for the two populations (10 resources and 5 consumers per unit area), and convert the two into an array (because our dCR_dt function take an array as input).
    R0 = 10
    C0 = 5 
#K = 50
    RC0 = np.array([R0, C0])

#numerically integrate this system forward from those starting conditions
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    f1 = p.figure()

    p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    textstr= '\n'.join((
        r'$r=%.2f$'%(r,),
        r'$a=%.2f$'%(a,),
        r'$z=%.2f$'%(z,),
        r'$e=%.2f$'%(e,)))
    props=dict(boxstyle='round', facecolor='lightgray', alpha=0.5)
    p.text(25, 16, textstr, fontsize=10, bbox=props)

    f2=p.figure()

    p.plot(pops[:,1], pops[:,0], '-r') # Plot (-r -> solid line, red)
    p.grid()
    p.xlabel('Resource Density')
    p.ylabel('Prey Density')
    p.title('Consumer-Resource population dynamics')
    textstr= '\n'.join((
        r'$r=%.2f$'%(r,),
        r'$a=%.2f$'%(a,),
        r'$z=%.2f$'%(z,),
        r'$e=%.2f$'%(e,)))
    props=dict(boxstyle='round', facecolor='lightgray', alpha=0.5)
    p.text(4, 11, textstr, fontsize=10, bbox=props)


    pp = PdfPages('../Results/LV2_models.pdf')
    pp.savefig(f1)
    pp.savefig(f2)
    pp.close()

#print final population size and amount of resources
    print('The final population size of consumers is:', int(pops[(pops.shape[0]-1),1]), 'individuals') #for a matrix of shape(n,m) where n=rows and m=columns, shape[0] gives the rows
    print('The final population size of resources is:', int(pops[(pops.shape[0]-1),0]), 'individuals')

LV()
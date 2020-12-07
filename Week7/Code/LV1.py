#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: LV1.py
#
# Description: this script plots the Lotka-Volterra model in two graphs
#
# Arguments: 0
#
# Input: python3 LV1.py
#
# Output: one pdf file containing two plots in ../Results/ directory 
#
# Date: November 2020

""" Script that plots Lotka-Volterra model"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'LV1.py'
__version__ = '0.0.1'
__license__= 'None'

#packages needed
import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
from matplotlib.backends.backend_pdf import PdfPages

def LV():
    def dCR_dt(pops, t=0):
        """a function that returns the growth rate of consumer and resource population at any given time step"""

        R = pops[0]
        C = pops[1]
        dRdt = r * R - a * R * C 
        dCdt = -z * C + e * a * R * C
    
        return np.array([dRdt, dCdt])

#assign parameter values
    r = 1.
    a = 0.1 
    z = 1.5
    e = 0.75

#Define the time vector; let’s integrate from time point 0 to 15, using 1000 sub-divisions of time
    t = np.linspace(0, 15, 1000)

    #Set the initial conditions for the two populations (10 resources and 5 consumers per unit area), and convert the two into an array (because our dCR_dt function take an array as input).
    R0 = 10
    C0 = 5 
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

    f2=p.figure()

    p.plot(pops[:,1], pops[:,0], '-r') # Plot (-r -> solid line, red)
    p.grid()
    p.xlabel('Resource Density')
    p.ylabel('Prey Density')
    p.title('Consumer-Resource population dynamics')

    pp = PdfPages('../Results/LV1_models.pdf')
    pp.savefig(f1)
    pp.savefig(f2)
    pp.close()

    print('The final population size of consumers is:', int(pops[(pops.shape[0]-1),1]), 'individuals') #for a matrix of shape(n,m) where n=rows and m=columns, shape[0] gives the rows
    print('The final population size of resources is:', int(pops[(pops.shape[0]-1),0]), 'individuals')

LV()
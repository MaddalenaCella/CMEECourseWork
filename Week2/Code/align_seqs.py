#!/usr/bin/env python3

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: align_seqs.py
# Description: program that takes DNA sequences from .csv file and aligns them
# Input: seqs.cvs from ../data/ directory
# Output: alignment.txt to ../results/ directory
# Date: October 2020

""" This Program takes DNA sequences from an external .csv file
    and saves the best alignment and score in a new text file """
__appname__="align_seqs.py"
__author__ = "Maddalena Cella (mc2820@ic.ac.uk)"
__version__ = "0.0.1"
__license__="None"

import sys

#input
seqs_f = open('../data/seqs.csv','r')

seqs = seqs_f.readlines() #readlines() splits file into lines
seq1 = seqs[0]
seq2 = seqs[1]

l1 = len(seq1)
l2 = len(seq2)

if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    #print("." * startpoint + matched)           
    #print("." * startpoint + s2)
    #print(s1)
    #print(score) 
    #print(" ")

    return score

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

#output
sys.stdout = open('../Results/alignment.txt','w')

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2
        my_best_score = z 
        
        print(my_best_align) 
        print(s1)
        print("Best score:", my_best_score)

sys.stdout.close()


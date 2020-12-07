#!/usr/bin/env python3

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: dictionary.py
# Description: python list comprehension exercise
# Date: October 2020

""" Python list comprehensions 4 """
__appname__="dictionary.py"
__author__="Maddalena Cella mc2820@ic.ac.uk"
__version__="0.0.1"
__license__="None"

taxa_dic = taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa.
taxa_dic = { } #create a dictionary grouped by order name
for elements in taxa:
    if elements[1] not in taxa_dic: 
        #add order name to directory if it does not exist
        taxa_dic[elements[1]] = [] 
    #add the species name to the list
    taxa_dic[elements[1]].append(elements[0])
print(taxa_dic)

# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc.
#  OR,
# 'Chiroptera': {'Myotis lucifugus'} ... etc
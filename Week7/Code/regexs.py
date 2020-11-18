#!/bin/env python3

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: regexs.py
#
# Description: Regular expressions in Python examples
#
# Arguments: 0
#
# Input: python3 regexes.py
#
# Output: different string matches
#
# Date: November 2020

""" Script that shows the use of regualar expressions"""
__author__ = 'Maddalena Cella mc2820@ic.ac.uk'
__appname__= 'regexs.py'
__version__ = '0.0.1'
__license__= 'None'
import re

my_string = "a given string"

match = re.search(r'\s', my_string)
print(match)

match.group()

match = re.search(r'\d', my_string)
print(match)

MyStr = 'an example'

match = re.search(r'\w*\s', MyStr) # what pattern is this?

if match:                      
    print('found a match:', match.group()) 
else:
    print('did not find a match')    

match = re.search(r'2' , "it takes 2 to tango")
match.group()

match = re.search(r'\d' , "it takes 2 to tango")
match.group()

match = re.search(r'\d.*' , "it takes 2 to tango")
match.group()

match = re.search(r'\s\w{1,3}\s', 'once upon a time')
match.group() 

match = re.search(r'\s\w*$', 'once upon a time')
match.group()

re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()

re.search(r'^\w*.*\s', 'once upon a time').group() # 'once upon a '

re.search(r'^\w*.*?\s', 'once upon a time').group() # 'once '

re.search(r'<.+>', 'This is a <EM>first</EM> test').group() # '<EM>first</EM>'

re.search(r'<.+?>', 'This is a <EM>first</EM> test').group() #'<EM>'

re.search(r'\d*\.?\d*','1432.75+60.22i').group() #'1432.75'

re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group() #' Theloderma asper'

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group() #'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'

MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group()

##Try the regex we used above for finding names ([\w\s]+) for cases where the person’s name has something unexpected, 
##like a ? or a +. Does it work? How can you make it more robust?
MyStr= 'Maddale$$ Ce?la'
match = re.search(r"[\w\s\W]+,\s[\w\.-]+,\s[\w\s\W]+", MyStr)

match.group()

MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"
emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr) 
for email in emails:
    print(email)

f = open('../Data/TestOaksData.csv', 'r')
found_oaks = re.findall(r"Q[\w\s].*\s", f.read())

found_oaks

MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a.academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a.academic@imperial.ac.uk, Some other stuff thats even more boring"

found_matches = re.findall(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+)", MyStr)
found_matches
for item in found_matches:
    print(item)


import urllib3

#open a connection
conn = urllib3.PoolManager() # open a connection
r = conn.request('GET', 'https://www.imperial.ac.uk/silwood-park/academic-staff/') 
webpage_html = r.data #read in the webpage's contents

My_Data  = webpage_html.decode()
#print(My_Data)

#extract names of academics
pattern = r"Dr[\s \']+\w+[\s \']+\w+[\s \']+"
regex = re.compile(pattern) # example use of re.compile(); you can also ignore case  with re.IGNORECASE 
for match in regex.finditer(My_Data): # example use of re.finditer()
    print(match.group())

New_Data = re.sub(r'\t'," ", My_Data) # replace all tabs with a space
print(New_Data)

#some excerices

#Try the regex we used above for finding names ([\w\s]+) 
#for cases where the person’s name has something unexpected, 
#like a ? or a +. Does it work? How can you make it more robust?
MyStr= "Maddal?na Ce£la"
match = re.search(r"[\w\W\s]+",MyStr)
match.group()

#Translate the following regular expressions into regular English

#match abc followed by either a or b as many times as it occurs, followed by a whitespace, a tab space and a number
#match any number no more than 2 times, followed by a slash, followed by another number no more than twice, followed by a slash and another number 4 times
#

#Write a regex to match dates in format YYYYMMDD, making sure that:
#Only seemingly valid dates match (i.e., year greater than 1900)
#First digit in month is either 0 or 1
#First digit in day ≤3

MyStr= "19971127 19981122 2021239"
match = re.findall(r"[12]?[90]?[0-9]?[0-9]+[01]?[0-9]+[1-3]?[0-9]?\s",MyStr)
match
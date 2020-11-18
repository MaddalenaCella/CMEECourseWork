""" This is a script that shows the use of subprocessing in Python"""

# Use the subprocess.os module to get a list of files and directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess
import re

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    if dir.startswith('C')==True:
        FilesDirsStartingWithC.append(dir) 
    for j in files:
        if j.startswith('C')==True:
            FilesDirsStartingWithC.append(j)

FilesDirsStartingWithC
 
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
FilesDirsStartingWithcC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for i in dir:
        if i.startswith('C')==True or i.startswith('c')==True:
           FilesDirsStartingWithcC.append(dir) 
    for j in files:
        if j.startswith('C')==True or j.startswith('c')==True:
            FilesDirsStartingWithcC.append(j)

FilesDirsStartingWithcC
#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
DirsStartingWithcC=[]

for (dir, subdir, files) in subprocess.os.walk(home):
    for i in dir:
        if i.startswith('C')==True or i.startswith('c')==True:
           DirsStartingWithcC.append(dir)
DirsStartingWithcC

'''
sample =[]
for (dir, subdir, files) in subprocess.os.walk(home):
    p=str(dir)
    sample=re.findall(r'\sU.+', p)
sample 


sample =[]
for (dir, subdir, files) in subprocess.os.walk(home):
    for i in dir:
        if i.startswith("C")==True:
            sample.append(dir)
    for j in files:
        if j.startswith("C")==True:
            sample.append(j)
sample 

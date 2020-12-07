#!/bin/bash
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: CountLines.sh
# Description: count the number of files present in a file
#
# Arguments: 1 -> file
# Date: Oct 2020

if [ "$1" == "" ] #check if file is null
then 
    echo "Please provide an input file you want to read"
else
    NumLines=`wc -l < $1` #create a variable that contains the count of the number of files in the file you have imputed
    echo "The file $1 has $NumLines lines"
    echo
    exit
fi
 


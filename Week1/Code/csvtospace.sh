#!/bin/bash
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: csvtospace.sh
# Description: substitute the commas in the files with spaces
#
# Saves the output into a .csv file but with spaces instead of commas 
# Arguments: 1 -> comma delimited file
# Date: Oct 2019

echo "Creating a space delimited version of $1 ..."
	
if [ -f $1 ]
then 
	if [ -s $1 ]
	then
	    if [ ${1: -4} == ".csv" ] #file "$1" | grep -q csv$ ${1: -4} == ".txt" 
	    then 
	        cat $1 | tr -s "," " " > $1tab.csv
	        echo "Done!"
	        exit
	    else
	        echo 'The file cannot be converted into a tab delimited file'
	        exit
        fi 
	else
	    echo 'The file is empty'
	    exit
    fi
else
	echo 'The file does not exist'
	exit
fi 

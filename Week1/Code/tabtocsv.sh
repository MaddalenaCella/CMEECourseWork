#!/bin/bash
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2020

echo "Creating a comma delimited version of $1 ..."
	
if [ -f $1 ] #check if file exists
then 
	if [ -s $1 ] #check if file has content or not
	then
	    if file "$1" | grep -q text$ #check if file is a text file
	    then 
	        cat $1 | tr -s "\t" "," >> $1.csv #if the file is a text file then convert it into .csv
	        echo "Done!"
	        exit
	    else
	        echo 'The file is in the wrong format and cannot be converted into csv'
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
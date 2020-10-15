#!/bin/bash
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: tiff2png.sh
# Description: convert tiff files into png files
# Date: Oct 2020

if [ -f $f ] # check if file exists
then 
	if [ -s $f ] # check if file has content
	then
	    if file "$f" | grep -q tif$ # check if file is in the correct format
	    then 
	        for f in *.tif; #if it is in the correct format then for all the .tif files ...
                do  
                	echo "Converting $f"; 
                    convert "$f"  "$(basename "$f" .tif).png";  # convert them into .png
            done
	    else
	        echo 'Please provide a .tif input file'
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

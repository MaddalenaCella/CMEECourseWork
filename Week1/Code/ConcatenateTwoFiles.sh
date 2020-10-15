#!/bin/bash
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: concatenate two files
#
# Arguments: 1 -> file, 2 --> file
# Date: Oct 2020

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ] 
then
    echo "Please provide two input files you want to concatenate and the name of the output file"
else
    cat $1 > $3 # concatenate and print content of $1, then redirected into $3
    cat $2 >> $3 # concatenate and print content of $2, then redirected into $3
    echo "Merged file is $3"
    cat $3 # print the concatenated file $3
    echo
    # move file to data directory
    echo "Moving $3 to ../Week1/Data/"
    mv $3 ../Week1/Data/ # move $3 to data directory
    exit
fi

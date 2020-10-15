#!/bin/bash
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: tabtocsv.sh
# Description: sshows the use of variables with two examples
#
# Date: Oct 2020

# Shows the use of variables
MyVar='some string'
echo 'the current value of the variable is' $MyVar
echo 'Please enter a new string'
while true; do
    read MyVar

    if [ -z "$MyVar" ] #if MyVar is not defined or empty
    then
        echo "No string entered"
    else
        break #if the variable is defined (you have entered a string), then break
    fi
done
echo 'the current value of the variable is' $MyVar

## Reading multiple values
echo 'Enter two numbers separated by space(s)'
while true; do
    read a b

    if [[ "$a" =~ ^[0-9]+$ || "$b" =~ ^[0-9]+$ ]] #check if a and b are numbers
    then 
        break #if they are, then exit the loop
    else
        echo "Error: the values you entered are not numbers" 
    fi
done

echo 'you entered' $a 'and' $b '. Their sum is:'
mysum=`expr $a + $b`
echo $mysum
exit
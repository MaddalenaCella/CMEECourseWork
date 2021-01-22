#!/bin/bash
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: wordcount.sh
# Desc: Calculates the wordcount of report 
#Input: sh wordcount.sh <any Tex file name with no extention>
# Date: January 2021

#Count the words and put it into MiniProject.sum in results subdirectory
#texcount -1 -sum CMEEproject.tex > ../Data/CMEEproject.sum
texcount -1 -sum $1.tex > ../Data/$1.sum
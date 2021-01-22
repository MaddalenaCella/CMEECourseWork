#!/bin/bash
# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: RunMiniProject.sh
# Desc: shell script that runs all the files for the mini project
# Arguments: none
# Date: January 2021

STARTTIME=$(date +%s) 

echo "The first step will clean up the data set and produce two tidied datasets."
Rscript GrowthData.r

echo "The first step is now completed."
echo "Now a script will run to fit some population growth models to the data."
echo "This might take some time..."

Rscript FittedData.r

echo "Model fitting has now terminated and the relevant information for the following step has been saved on the Results directory."
echo "Now two scripts will run to compare the performance of the different models fitted both visually and statistically."

Rscript SelectData.r

echo "A script looking at the growth curves of three bacteria will now run."
Rscript growth_curves.r

echo "These scripts have generated some plots which are reported in the MiniProject Report."
echo "Now a script will run that performs the model fitting and comparison of the fitting to the global dataset."
echo "This might take some time..."

Rscript Tempoverall.r

echo "All the fitting scripts have run successfully."
echo "The MiniProject compilation will start now."


sh wordcount.sh CMEEproject
#texcount -1 -sum CMEEproject.tex > ../Data/CMEEproject.sum

pdflatex CMEEproject.tex > /dev/null 2>&1
pdflatex CMEEproject.tex > /dev/null 2>&1
bibtex CMEEproject > /dev/null 2>&1
pdflatex CMEEproject.tex > /dev/null 2>&1
pdflatex CMEEproject.tex > /dev/null 2>&1


mv CMEEproject.pdf ../Results  
# moves output (pdf version of texfile) to Results

ENDTIME=$(date +%s) 
evince ../Results/CMEEproject.pdf 

#remove extra files produced other than the pdf of the report
rm *.aux
rm *.bbl   
rm *.blg    
rm *.log
rm *.out

echo "LaTeX Compiled and unwanted files removed." 

echo "It took $(($ENDTIME - $STARTTIME)) seconds to run this miniproject."
## Week1

Week1 is a folder containing data and code for Unix/Linux commands and shell scripts as well as the first three assignments of the CMEE Masters programme

The Week1 directory is further organised in two subdirectories, Data and Code. They contain the necessary files and commands to perform the Unix/Linux and shell scripting assignmnets. There is also an additional subdirectory containing some trial scripts.

## Prerequisites

Before you begin, ensure you:

* have a Linux or Mac machine. 
* have a code editor (for example Visual Studio Code, Atom, WIM, etc...)

You are not required extra packages to be able to reproduce the assignmnets on your device.

## Content of Code subdirectory

In the Code sub-directory you can find the following shell script files:

* boilerplate.sh : a shell script that prints 'This is a shell script'
* ConcatenateTwoFiles.sh : a shell script that concatenates the content of two input files
* CountLines.sh : a shell script that counts the files in a file
* csvtospace.sh : a shell script that converts csv files to space delimited files
* MyExampleScript.sh : a shell script that prints ' Hello ' followed by the User name
* variables.sh : a shell script showing the use of variables
* tabtocsv.sh : a shell script that converts tab-delimited files into csv files
* tiff2png.sh : a shell script that converts a tif file into png file

And the following text file:
* UnixPrac1.txt : a text file containing 5 Unix shell commands to perform certain tasks on some FASTA files

## Content of Data and Data/Temperatures/ subdirectories

In the Data sub-directory you can find the following FASTA files dowloaded from https://github.com/mhasoba/TheMulQuaBio/tree/master/content/data/fasta:

* 407228326.fasta
* 407228412.fasta
* E.coli.fasta

You can find the following variables created when running the last line of code of UnixPrac1.txt:

* nAT
* nCG

Within the Data/Temperatures/ sub-directory you can find the following csv files obtained from https://github.com/mhasoba/TheMulQuaBio/tree/master/content/data/Temperatures:

* 1800.csv
* 1801.csv
* 1802.csv
* 1803.csv

And their outputs after running the csvtospace.sh shell script:

* 1800.csvtab.csv
* 1801.csvtab.csv
* 1802.csvtab.csv
* 1803.csvtab.csv

## Running UnixPrac1.txt

To be able to perform the five UNIX shell commands on the FASTA files (available at https://github.com/mhasoba/TheMulQuaBio/tree/master/content/data/fasta) you need to run each line on your terminal making sure to be in the correct directory.

## Running csvtospace.sh

To be able to run this shell script that converts csv files into space delimited files, you need write over some csv files. For the assignmnet, I run it on the Temperature csv files available at https://github.com/mhasoba/TheMulQuaBio/tree/master/content/data/Temperatures.

## Running the improved shell scripts

Run the improved shell scripts on your terminal making sure to have the correct input files.

## Contributors

Thanks to [@mhasoba](https://github.com/mhasoba) for teaching me the skills to ba able to perform the Week1 assignments, my group (group 4) and PokMan for the incredible help and support.


## Contact

If you want to contact me you can reach me at <mc2820@ic.ac.uk>.

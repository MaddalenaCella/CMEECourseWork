## Week2

Week2 is a folder containing scripts and programs written in Python programming language (in Code), as well as the input files necessary to run those script (in Data) and their outputs (in Results). Python test files can be found in the Sandbox subdirectory.
 

## Prerequisites

Before you begin, ensure you:

* have a Linux or Mac machine. 
* have a code editor (for example Visual Studio Code, Atom, WIM, etc...)
* have Python 3 version: 3.7.3

It is adviced you install the Python package 'ipython' by:
```sh
pip install python ipython
```
or 
```sh
sudo apt install python ipython
```

## Content of Code subdirectory

In the Code sub-directory you can find the following pyhton files in alphabetical order:

* align_seqs.py : program that takes the DNA sequences as an input from a single external file from `Week3/Data/` directory and saves the best alignment along with its corresponding score in a single text file on `Week3/Results/` directory.

* basic_csv.py : script that shows the use of Python's csv package 

* basic_io1.py : script that shows how to import data in python

* basic_io2.py : script that shows how to import data in python 

* basic_io3.py : script that shows how to store objects and save them for later use using 'pickle' 

* boilerplate.py : example of Python program

* cfexercises1.py : modified Python code to make it a program that evaluates all the foo_x functions

* cfexercises2.py : functions that use loops and conditionals

* control_flow.py : example of program that uses control statements

* debugme.py : example of a function with a bug

* dictionary.py : Python list comprehension exercise 4

* lc1.py : Python list comprehension exercise 1

* lc2.py : Python list comprehension exercise 2

* loops.py : script containing examples of both for and whie loops

* oaks.py : script that finds which species are oak trees from a list of tree taxa

* scope.py : script containing blocks of code to explain variable scope

* sysargv.py : script to explain sys.argv

* tuple.py : python list comprehension exercise 3

* using_name.py : script that illustrates the use of modules

## Content of Data subdirectory

In the Data sub-directory you can find the following .csv files:

* bodymass.csv: available at (https://github.com/mhasoba/TheMulQuaBio/tree/master/content/data)

* testcsv.csv: the output file of basic_csv.py

And another .csv file I created containing two DNA sequences to align:

* seqs.csv

## Running Python files

To run the python scripts make sure you are in the correct directory `Week3/Code/` and run them on Bash:

```sh
pyhton3 <script_name> 
```
or:
```sh
ipython <script_name>
```
Or from within the ipython shell:

```sh
run <script_name>
``` 

## Contributors

Thanks to [@mhasoba](https://github.com/mhasoba) for teaching me the skills to ba able to perform the Week1 assignments, my group (group 4) and PokMan [@ph-u](https://github.com/ph-u) for the incredible help and support.

## Contact

If you want to contact me you can reach me at <mc2820@ic.ac.uk>.
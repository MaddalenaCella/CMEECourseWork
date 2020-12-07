#!/usr/bin/env python3

"""Description of this program or application.
	You can use several lines"""

__appname__ = '[application name here]'
__author__ = 'Maddalena Cella (mc2820@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "None"

## imports ##
import sys # module to interface our program with the operating system

## constants ##
'''
def foo(x,y): #this is just an example
    print(x)
    print(y)
'''
## functions ##
def main(argv): #argv: will only have name of the function--> currently it has no input
    #but internally here you can pass stuff that will be inputted in the function you define before (foo)
    """ Main entry point of the program """
    print('This is a boilerplate') # NOTE: indented using two tabs or 4 spaces
    #foo(1,2)
    return 0

if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit("I am exiting right now!")
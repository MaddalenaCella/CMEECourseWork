import ctypes #allows to interact with C environment
from ctypes import *

ccalc = CDLL("./ccalc.so")

#type(ccalc.add) #access function add

ccalc.add.argtypes = [c_float, c_float] #takes two floats (float a and b)
ccalc.add.restype = c_float

ccalc.add(2,3) #5.0


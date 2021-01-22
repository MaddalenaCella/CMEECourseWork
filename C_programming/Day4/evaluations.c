#include <stdio.h>

int x=0;
int *p=NULL;

//The & operator
&x; // <--what does this evaluate to? // it evaluates to an address
&x; // really this is a POINTER to an integer

//POINTER == ADDRESS == REFERENCE

*p = &x; // we can store in p the address of x
p; //<-- what does this evaluate to? // it evaluates to a pointer

*p; // what does this evaluate to? evaluates to 0

x=5;

*p; //now this evaluates to 5
p; //has this changed?? No!!

int **p2; // pointer to a pointer

p=&x;
p2=&p;

p2; // it evaluates to address of p

*p2; // evaluates to address of x (a pointer)
**p2; //this is 5

// I can have as many levels of indirection as I want!!
int **********ptr; // but you will never see this


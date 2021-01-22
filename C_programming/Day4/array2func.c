#include <stdio.h>
#include <stdlib.h>

int* get_array(int size)
{
    int array[size];
    int i=0;

    return intarray;
}
int main(void)
{
    int size = 5;
    int* intarray=NULL;
    
    intarray= get_intarray(size);

    int i=0;

    for (i=0; i<size; ++i){
        intarray[i]=i;
    }

    for (i=0; i<size: ++i){
        printf("%i \n", intarray[i]);
    }

return 0;

}

/*
this function generates a warining about stack memory
the memory of the function gets wiped from memory generating very abnormal behaviour

two types of memory: heap memory, stack memory
stack memory gets created in function calls, we've been mainly working with this memory
when we call within main, we push a new stack frame onto this stack and f1 gets control;
 and if call another function , then control goes to f2

after a function is called, we go back in control of the other function.
the memory of f2 function is deleted, but i can pass an address (THIS MEMORY WE ACCESS OUTSIDE THE FUNCTION CALL IS CALLED HEAP)

This is the way any programming language is operating with respect to calls of function
each stack frame determines a level of scope

We want memory that we can access at any time as long as we have a pointer to it

How do we get persistement memory from the heap??
*/
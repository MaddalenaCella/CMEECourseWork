#include <stdio.h>
#include <stdlib.h>

//the bad way
/*
int* get_array(int size)
{
    int array[size];
    int i=0;

    return intarray;
}
*/

//the good way

//void* malloc(size_t s); // their return type is pointer to void
//malloc stands for memory allocation: returns bloc of memory

//void* calloc(size_t nelems, size_t size); // their return type is pointer to void
//stands for cancel allocation: initialises block of memory

//there is a function called realloc, but isn't guaranteed to give the same pointer back

// void is unspecified data type: depending if we have int, char and long int, we jump different bytes
int* get_intarray(int nelms)
{
    int *ret= NULL;
    //ret= malloc(nelms * sizeof(int)); //sizeof() ensures portability 
    //free(ret); //this avoids memory leak
    ret= calloc(nelms, sizeof(int)); //A bit slower, clears everything to 0
    if (ret==NULL){
        printf("Warning:insufficient memory for operation!\n")
    }

    return ret;
}

void *safe_malloc(size_t, size)
{
    void *ret =NULL;
    ret= malloc(size);
    if (ret==NULL){
        printf("Insufficient memory for operation!\n");
        exit(1); //quits program. a bit aggressive
    }
    return ret;
}

void safe_free(void **p) //function that frees the memory and reinitialise the memory
{
    if (*p != NULL){
        free(*p);
        *p=NULL;
    }
}

int main(void)
{
    int size = 5;
    int* intarray=NULL; // poiter to int
    
    //intarray= get_intarray(size);
    intarray=safe_malloc(size * sizeof(int));

    int i=0;

    for (i=0; i<size; ++i){
        intarray[i]=i;
    }

    for (i=0; i<size: ++i){
        printf("%i \n", intarray[i]);
    }

    //free(intarray); //free memory
    safe_free((void **)&intarray); //type casting to silence warnings
    
    intarray=NULL;
    // what is the value of intarray now??<-- now it's a pointer
    //which does this:
    /*
    if (intarray!= NULL){
        free(intarray);
        intarray=NULL;
    }*/

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
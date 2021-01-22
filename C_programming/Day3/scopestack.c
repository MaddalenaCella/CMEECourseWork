#include <stdio.h>
#include <stdlib.h>

void index_through_array(int mynumbers[5], int *index)
{
    while (*index < 5){
        printf("Element %i: %i\n", *index, mynumbers[*index]);
        mynumbers[*index] += *index;
        ++(*index);
    }
}
void printarray(int array[], int size)
{
    int i= 0;
    for (i = 0; i< size; ++i){
        printf("%i", array[i]);
    }
    printf("\n");
}

int main (void)
{
    int index=0;
    int mynums[]={19, 81, 4, 8, 10};

    //pointers _type_ *variable name:
    // you can point to any type of C data
    int *ptr1=NULL; // ptr1 is a pointer to an integer
    int* ptr2=NULL; //ptr2 is also a pointer to an integer

    int a, b;
    ptr1= &a;
    ptr2= &b;

    //
    ptr1= &index; //address 

    // indirectly access index through ptr1
    // indirection operator: *
    ptr1; // this evaluates to &index: a memory address
    *ptr1; //this evaluates to 0; gets the data at the address

    // initialise a and b through a pointer
    *ptr1=4;
    *ptr2=5;
    printf("The sum of a and b is: %i\n", *ptr1 + *ptr2);

    printf("Value of index before function call: %i\n", index);
    //printf("Elements in mynums before function: ");
    //printarray(mynums, 5);
    index_through_array(mynums, ptr1); //pass index to this function
    printf("Value of index after function call: %i\ni", index);
    //printf("Element in mynums after function: ");
    //printarray(mynums, 5);

    return 0;

}
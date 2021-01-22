#include <stdio.h>
#include <stdlib.h>

int main(void){

float mydata[]= {22.1, 32.55, 64.8, 12.0};
float* fltptr = NULL;
float* fltptr2=NULL;
float f= 25.6;

fltptr = &f; // this points to the float f

fltptr = mydata; //this now point to mydata i.e. first element of my data

*fltptr; // this evaluates to 22.1

fltptr = &mydata [2];

*fltptr; //this evaluates to 64.8

fltptr = mydata;

printf("Check this out : %f\n", fltptr[2]);
printf("tecnically correct : %f\n", *(fltptr + 1));

// ypu can also increment a pointer!!
// can assign between pointers

//fltptr2= mydata;

//to assign from floatpointer to float pointer 2
fltptr2= fltptr;

//we can increment float pointers
int i;
for (i=0; i <4; ++i){
    printf("%f", *fltptr2);
    fltptr2++;
}

//looping with only pointer arithmetic
printf("\n\n");
fltptr2= &mydata[3];
for(fltptr = mydata; fltptr <= fltptr2; ++fltptr){
    printf("%f", *fltptr);
}

    return 0;
}
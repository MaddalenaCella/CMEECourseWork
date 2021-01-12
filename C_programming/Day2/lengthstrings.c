#include <stdio.h>
#include <string.h>

//a string is a type of Array
int main(void){
    char string1[50]={'a',' ', 's', 't', 'r', 'i', 'n', 'g', '\0'}; //declared length of 50, but actual length of 8
    char string2[50]="a string"; //formats to the above

    //function prototypes:
    // size_t strlen(const char * str);
    // size_t : unsigned long integer
    // char * refers to a pointer


    // for our puproses we understand this to mean:
    // unsigned long int strlen(const char []);
    // this is is the interface of the function

    long len =0;
    len= strlen(string2);

    printf("The length of string 2 is: %i\n", len);

return 0;
}
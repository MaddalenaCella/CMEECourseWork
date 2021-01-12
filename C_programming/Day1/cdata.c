#include <stdio.h> //comment single line

int main(void)
{
    int x=0; //a place in memory for an integer
    char c; // a character
    float flt; //a floating point number
    double dbl; // a double precision float

    x= 1111; // we cannot have arbitrarely large values in here
    //x is our variable name; indicates storage for type int
    //1111 is an integer literal (a constant literal)

    flt= 3.1415926535897932846;

    printf("The value in x is: %i.\n", x);
    printf("The value in flt is: %f. \n", flt);
    printf("The value in flt is: %.25f. \n", flt); // adding .25 tells how many decimal places you want to print
    //sometimes the value returned is different because we might have overstored 
    /* The value in flt is: 3.141593. 
    The value in flt is: 3.1415927410125732421875000. */
    return 0;
}
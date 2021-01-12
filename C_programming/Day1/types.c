#include <stdio.h>

int main(void)
{
    int x;
    long int longx;
    char c;

    x=58;
    c= 'A'; //single quotes when assigning char 

    c=x;
    x=c;

    printf("x is %i\n", x);
    //printf("c is %c\n", c);

    return 0;
}
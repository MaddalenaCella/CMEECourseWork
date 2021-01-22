#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    //program that measures the number of bytes in any integral type in C
//int ints[2];
long int ints[2];
//want to have this look like so:
//{0000..000, 111111...111};

ints[0] = 0;
ints[1] = 0L;

int nbytes; //counter for number of bytes
char* cptr; //character is 1 bytes

cptr= (char*)ints;

/*
cptr[0]; // this would evaluate to 0
cptr[1]; // this also evaluates to 0
printf("%i\n", cptr[0]);
printf("%i\n",cptr[1]);
*/

while(cptr[nbytes]==0){
    ++nbytes;
}
//--nbytes;
printf("Number of bytes in a long integer: %i\n", nbytes);

return 0;
}
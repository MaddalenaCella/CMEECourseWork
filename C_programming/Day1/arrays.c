#include <stdio.h>

int main(void)
{
    int x=0;
    int intarray[5]; //explicitely sized
    int intarray2[]= {1,2,3,4,5,6}; //implicitely sized array
}
printf("intarray at index %i is %i\n",0, intarray[0]);
printf("intarray at index %i is %i\n",1, intarray[1]);
printf("intarray at index %i is %i\n",2, intarray[2]);
printf("intarray at index %i is %i\n",3, intarray[3]);
printf("intarray at index %i is %i\n",4, intarray[4]);
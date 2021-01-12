#include <stdio.h>
#include <stdbool.h>
int main (void){

int i;
_Bool b; // definition of storage for 1 or 0.
      // Reality: smallest addessable unit is byte (8 bits)
//ie:
b= 0;
b = 1;

bool c;
printf("Value in b: %i\n",b);

b = 5;
printf("Value in b: %i\n",b);


b = 256;
printf("Value in b: %i\n",b);
c = true;
c = false;

bool site1[]= {true,true,true,false,true};
bool site2[]= {false,true,true,false,true};


    return 0;
}
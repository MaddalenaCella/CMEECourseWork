#include <stdio.h>

int main(void) {
  //int isMultiple = 1;
    int seven=7;
    int ten=10;
    int counter = 0;
  for (int i= 1; counter <=33 ; ++i) {
    
    if (i % seven==0 || i % ten==0) {
        //isMultiple = 1;
        printf("%i, \n", i);
        counter++;
    }
  
  }
  return 0;
}

/* Write a loop that only prints the integers that are a multiple of 10 or/and 7 (tip, use the modulo % operator!) between 1 and 100.

Now change this loop so that it runs until it prints out 33 multiples of 10 or/and 7.*/
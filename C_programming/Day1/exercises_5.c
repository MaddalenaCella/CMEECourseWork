#include <stdio.h>

/*Constants and data type conversions

Write a small program to explore the interaction of the basic data types and constants. Use printf() to show the results. For instance:

    Add or subtract from an arbitrary character value
    Add or subtract a whole constant number to or from a floating-point number
    What happens when you apply a character constant in an arithmetic operation? (i.e. add a char to a float?)

Testing cast results

Have you ever wondered what happens when you type cast a char to an int? Or vice versa? Write a program that uses printf to test the results of some typecast conversions.
Deincrement and increment

Write a program that tests the assignments of different pre- and postfix increment/de-increment operations*/

int main (void)
{
/*
  char a='a';
  char b='b';
  char c=0;

  c= a + b;

  printf("The value of c: %c\n", c);

  int x= 2;
  float y= 3.45;
  float z=0.0;

  z= x-y;

  printf("The value of z: %f\n", z);

  float y= 3.45;
  char b='b';
  float w=0.0;

  w= y+b;

  printf("The value of w: %f\n", w);*/

  char d='d';
  int q=120;
  d= (char)q;

  printf("The value of d: %c\n", d); //ASCII 120 is X


  return 0;

}
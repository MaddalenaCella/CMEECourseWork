#include <stdio.h>

int main (void)
{

  int x=1;
  int w='w';
  float sex= 6.969;
  double welike= 6.9;

  printf("The value of x: %i\n", x);
  printf("The value of w: %i\n", w); // if i assign a char as an integer I get the ASCII value of that letter
  printf("The value of sex: %.3f\n", sex);
  printf("The value of welike: %e\n", welike);

  return 0;

}

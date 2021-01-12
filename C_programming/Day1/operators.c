#include <stdio.h>
int main(void)

{
    int a =1, b=2, c=0;
c = 1+ 4;
c = a+ b;
c = a+ 4;

printf("The variable c is :%i \n",c);

c = a / b;

float f = 0.0;

f = a / b;
printf("The variable c is :%i \n",c);
printf("The variable c as a float is :%f \n",f);

f = (float)a / (float)b;
printf("The variable c as a float is :%f \n",f);

return 0;
}
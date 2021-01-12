#include <stdio.h> //comment single line
/* multi line commenting
you can write as much as you want but need to close it */
int main(void)
{
    printf("Hello World!\n"); //this for reporting to user
    //statements always end with a semi column
    printf("This is an integer: 1\n");
    printf("This is an integer: %i. \n", 234);
    printf("This is an integer: %i. \nThis is another integer: %i\n", 234,1);
    return 0; //this returns code to the OS--> if it is 0-->all ok!!
}

/* this can be written on a single line apart from the first line 
#include <stdio.h>
int main(void){printf("Hello World!\n");return 0;} */

/* all this stuff is valid in C++ */

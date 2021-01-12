#include <stdio.h>

// need to declare the function before i can use it in the source code
// do not use global variables 
float fltdiv(const int x, const int y) //head of the function: takes two integer, const makes it more secure--> indicates that we are not gonna change x and y
{
    float retval =0.0;

    retval= (float)x/ (float)y;

    return retval;
}
// I could also include the function prototype and then the function below the main
float fltdiv(const int x, const int y);
// and then add the function belowthe main
// why would we use prototype? and not declare function ahead? in some cases you need a sequence in which functions need other functions so there has to be an order to the functions


// void return, void parameters
void myfunction(void)
{
    //
}

//be careful about what  types you pass in the function: if it accepts integers then you can only input integers

int main(void)
{
    int a =7;
    int b =3;

    // my function does this: float x = (float)a/b;

    float x;
    x= fltdiv(a, b);

    printf("%i divided by %i is: %f\n", a, b, x);

    return 0;
}
float add (float a, float b)
{
    return a + b;
}

float subtract (float a, float b)
{
    return a - b;
}

float multiply (float a, float b)
{
    return a * b;
}

float divide (float a, float b)
{
    return a / b;
}

//this is a library
//can compile it using 'gcc -c ccalc.c'
//look at chapter 15 of github page
//compile it to create a shared library: a dinamically linked library
//'gcc -shared -Wall -o ccalc.so -fPIC ccalc.c' //.so means shared object//-fPIC protects memory space


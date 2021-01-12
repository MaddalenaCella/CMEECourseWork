#include <stdio.h>
int main(void)
{
    int x =0;
    int y =1;
if (x) {
    printf("yes, 1\n");
    printf("Will this line print?\n");

}
else {
    printf("x must be 0 \n");
}

// !=  not equal to
// && AND logic
// || OR logic
// ! NOT logic
// a operator b

if (x==y){
    printf("x and y are equal\n");
}
else {
    printf("imma fuck you tonight\n");
}

if (x != y){
printf("not equal x and y\n");
}
if (x && y){
    printf("Yes to x and y\n");
}

if (x || y ){
    printf("me llamo edvinas\n");
}

//x ==y not same as x && y
// x && y only for 0 and 1, true or flase
// x == y for any integer
// x = 4
// in this case x &&Y is now true while x==y still false


return 0;
}
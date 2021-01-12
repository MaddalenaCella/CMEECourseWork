#include <stdio.h>

int main(void)
{
    int x=0;
    int myarray1[]={1,2,3,4}; //explicitely sized, initialised at 0
    int myarray2[]= {2,2,2}; //implicitely sized array
    int result[7];

    //how to add two arrays together
    int i=0;
    //concatenation
    for (i=0; i<7; ++i){
        if (i<4){
            result[i]= myarray1[i];
        }else{
            result[i]= myarray2[i-4];
        }
    }
    for (i=0; i<7; ++i){
        printf("%i\n",result[i]);
    }

    //summing
    for(i=0; i<3; ++i){
        //myarray1[1]= myarray1[i]+myarray2[i];
        myarray1[i] += myarray2[i];
    }

    printf("Summed arrays:\n");
    for (i=0; i<4; ++i){
        printf("%i\n", myarray1[i]);
    }


return 0;
}
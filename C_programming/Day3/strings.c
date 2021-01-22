#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]){

//char astr1[] = "This is a string";
//char* astr2 = "This is a also string";

char* placenames[] = {"sheffield", 
                      "dick",
                      "reactor"};  //array of strings

/*
char** placenames = {"sheffield", 
                      "silwood",
                      "reactor"}  //array of strings

*/

printf("I've played croquet on the: %s\n", placenames[2]);
printf("I've played croquet on the: %s\n", *(placenames+1));



    return 0;
}
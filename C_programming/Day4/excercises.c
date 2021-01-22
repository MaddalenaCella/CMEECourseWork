#include <stdio.h>
#include <string.h>

int reverse_string(char str[])
{
    int i;
    int lim;
    int j= strlen(str)-1;
    char c;

    lim= j/2;

    for(i=0; i<=lim; ++i){
        c= str[j];
        str[j]= str[i];
        str[i]= c;
        --j;

    }
    printf("%s\n", str);
    return 0;
}

_Bool str_compare1(const char* str1, const *char str2)
{
    int i=0;
    int lim = 0;
    if (strlen(str1)> strlen(str2)){
        return 1;
    }

    for(i=0; i<strlen(str1); ++i){
        if (str[i] != str2[i]){
            return 1;
        }
    }
    return 0;
}

int str_compare2(char *str1, char* str2){
    while(*str1 && *str2){
        if (*str1 !+ *str2){
            return 1;
        }
        ++str1;
        ++str2;
    }
    if (*str1 != *str2){
        return 1;
    }
    return 0;
}

//checking for palyndrome
int ispalindrome (char* str){
    int i;
    int lim;
    int j= strlen(str)-1;
    char c;

    lim= j/2;

    for(i=0; i<=lim; ++i){
        if str[i] != str[j]{
            return 1;
        }
        --j;
    }
    printf("%s\n", str);
    return 0;

}
int main(int argc, char* argv[])
{
    if (argc != 3){
        printf("*********************\n");
        printf("Welcome to string comparer\n");
        printf("Insert two strings ypu'd like to revers as arguments to the program\n");
        printf("eg. ./a.out \"Hello!\"\n");
        printf("*********************\n");
        return 0;
    }

/*to check if string is palindrome
    reverse_string(argv[1]); //argv[1] is 
        if ispalindrome(argv[1]){
        printf("This is not a palindrome\n");
    } else{
        printf("It is palindromic\n");
    }
    */


/* if(strcomp(argv[1], argv[2])){
        printf("strings are different\n");

    }else{
        printf("Strings are the same\n");
    }
}
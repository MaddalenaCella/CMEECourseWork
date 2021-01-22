#include <stdio.h>
#include <string.h>

int reverse_string(char str[])
{
    int i; 
    int lim; 
    int j = strlen(str)-1;
    char c;
    
    lim = j/2;

    for (i = 0; i <= lim; ++i) {
        c = str[j];
        str[j] = str[i];
        str[i] = c;
        --j;
    }

    printf("%s\n", str);
    return 0;
}

int str_compare1(const char* str1, const char* str2) 
{
    int i = 0;
    int lim = 0;
    if (strlen(str1) != strlen(str2)) {
        return 1;
    }

    for (i = 0; i < strlen(str1); ++i) {
        if (str1[i] != str2[i]) {
            return 1;
        }
    }

    return 0;
}

int str_compare2(char *str1, char* str2)
{
    while (*str1 && *str2) {
        if (*str1 != *str2) {
            return 1;
        }
        ++str1;
        ++str2;
    }

    if (*str1 != *str2) {
        return 1;
    }

    return 0;
}

int main(int argc, char* argv[]) 
{
    if (argc != 3) {
        printf("*******************************\n");
        printf(" Welcome to string comparer\n");
        printf(" Enter two strings you'd like to revers as arguments to the program\n");
        printf(" e.g. ./a.out \"Hello!\"\n");
        printf("*******************************\n\n\n");
        return 0;
    }

    char* str1 = "This is a string";
    char* str2 = "This is another string";


    str_compare2(str1, str2);
/*    if(strcmp(argv[1], argv[2])) {
        printf("Strings are different\n");
    } else {
        printf("Strings are the same\n");
    }*/
    if(str_compare2(argv[1], argv[2])) {
        printf("Strings are different\n");
    } else {
        printf("Strings are the same\n");
    }

    return 0;
}

#include <stdio.h>
#include <string.h>

int reverse_string(char str[])
{
    int i; 
    int lim; 
    int j = strlen(str)-1;
    char c;
    int ispalindrome = 0;
    
    lim = j/2;

    for (i = 0; i <= lim; ++i) {
        if (str[i] != str[j]) ispalindrome = 1;
        c = str[j];
        str[j] = str[i];
        str[i] = c;
        --j;
    }

    printf("%s\n", str);
    return ispalindrome;
}

int ispalindrome(char* str) 
{
    int i; 
    int lim; 
    int j = strlen(str)-1;
    char c;
    
    lim = j/2;

    for (i = 0; i <= lim; ++i) {
        if (str[i] != str[j]) {
            return 1;
        }
        --j;
    }

    printf("%s\n", str);
    return 0;
}

int main(int argc, char* argv[]) 
{
    if (argc != 2) {
        printf("*******************************\n");
        printf(" Welcome to string reverser\n");
        printf(" Enter a string you'd like to reverse as an argument to the program\n");
        printf(" e.g. ./a.out \"Hello!\"\n");
        printf("*******************************\n\n\n");
        return 0;
    }

    reverse_string(argv[1]); // argv[1] is the first command-line argument
    if (ispalindrome(argv[1])) {
        printf("This is not a palindrome\n");
    } else {
        printf("It is palindromic\n");
    }

    return 0;
}

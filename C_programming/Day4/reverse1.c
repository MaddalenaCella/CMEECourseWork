#include <stdio.h>

int reverse_string(char str[])
{
    int len = strlen(str);
    char out[len]; // Variable-length array (or VLA)
    int i;
    for (i = len-1; i >= 0; --i){
        out[len-i] = str[i];
    }
    printf("%s\n", out);
    return 0;
}

int main(void) 
{
    char str1[] = "Hello!";
    reverse_string(str1);
    return 0;
}

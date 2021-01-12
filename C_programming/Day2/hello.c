#include <stdio.h>
#include <stdbool.h>
int main (void){

int x =5;
bool overlap = false;
bool site1[]= {true,true,true,false,true};
bool site2[]= {false,true,true,false,true};
bool siteo[x];
//site
for (int i =0; i < 5 ; ++i){
    if (site1[i] == true){
        siteo[x - i] = 1;
    }
    printf("ello %i\n", (int)siteo);
}

return 0;
}
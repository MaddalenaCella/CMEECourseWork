#include <stdio.h>
#include <stdlib.h>
//structure is the fundaments of object oriented programs

struct site_data {
// we cann put as many C types as the compiler knows about
float longitude;
float latitude;
float elevation;
char** species;
int nspecies;
int* sppcounts;
};


//create an alias
//typedef __datatype__ __alias__
typedef struct site_data site_data;
//typedef char dna_t; //typedef to store DNA data

//we have defined for the compiler an abstract type

int main(void)
{
    site_data s1;//instantiating the struct
    site_data s2;

    site_data sites[20];
    site_data *sites_ptr= NULL;

    sites_ptr = malloc (20 * sizeof(struct site_data));

    s1.latitude = 75.2221; // . points to the memeber of a struct
    s2.longitude = -1.0001;

    s2.longitude = s2.longitude + 2.0; 

}
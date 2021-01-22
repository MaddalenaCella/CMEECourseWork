#include <stdio.h>
#include <stdlib.h>

struct node{
    int index;
    int data;
    struct node *next;
};

struct tnode {
    struct node* left;
    struct node* right;
    struct node* anc;
};

typedef struct node node;

void traversell(node *n)
{
    //printf("%i ", n->index); // In preorder
    if (n->next != NULL){
    traversell(n->next);   
    }
    printf("%i ", n->index); //In postorder:numbers get printed backwards
}

void remove_nth_node()
{
        if (n->next != NULL) {
        if (n->index == i){
            n->next = (n->next)->next;
        }
        remove_ith_node(i, n->next);
    }
}

int main(void){
    node n1;
    node n2;
    node n3;
    node n4;

    node *nptr;

    nptr = &n1;

    printf("Index in n1: %i\n", n1.index);
    (*nptr).index =5;
    printf("Index in n1: %i\n", n1.index);
    nptr->index = 7; //built-in C function
    printf("Index in n1: %i\n", n1.index);

    n1.index=1;
    n2.index=2;
    n3.index=3;
    n4.index=4;

// a linked list
    n1.next = &n2;
    n2.next = &n3;
    n3.next = &n4;
    n4.next = NULL;

    //n1==>n2==>n3==>n4
    traversell(&n1);

    // Simple removal
    n1.next = &n3;

    traversell(&n1);
    printf("\n");

    return 0;
}
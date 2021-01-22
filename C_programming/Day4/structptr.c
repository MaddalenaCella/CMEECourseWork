#include <stdio.h>
#include <stdlib.h>

struct node {
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
    //printf("%i ", n->index); // In preorder: prints indices in ascending order
    if (n->next != NULL) { //we check if value in n is set to null
        traversell((*n).next);//(*n) this expression gives a struct node. (*n).next gives a pointer to another node
    }
    printf("%i ", n->index); // In postorder: will print the indices in reverse
}

void remove_ith_node1(unsigned int i, node *n) //template for this
{
    if (n->next != NULL) {
        if (n->next->index ==i){ //if current n is 0-> this evaluates to 1 (index of the next object)
            //checks if current index is equal to index we want to remove
        n->next = n->next->next; //this pointer is pointing to the node with index 2 (third one in the list)
        return;
    } //now that we have a removed an element from the list, the program will not behave in a predictable manner:when you reorder them indices are wrong
        remove_ith_node(i, n->next);
    }
}

void remove_ith_node2(const unsigned tgt, unsigned i, node *n) //template for this
{
    /* a function to remove the ith element in a linked list*/
    ++i;
    if (n->next != NULL) {
        if(tgt == i){ //if next node has index i
        p = n->next; //store the address before making changes
            n->next = n->next->next;
            p->next->next= NULL; //this closes separate entries to the list
            return;
        }
        remove_ith_node(tgt, i, n->next);
    } else {
        printf("Index %i out of bounds!\n", i);
    return;
    }
}


int main(void)
{
 /*   node n1;
    node n2;
    node n3;
    node n4;
    node n5;
    node n6;

    n1.index = 1;
    n2.index = 2;
    n3.index = 3;
    n4.index = 4;
    n5.index = 5;
    n6.index = 6;

    // A linked list
    n1.next = &n2;
    n2.next = &n3;
    n3.next = &n4;
    n4.next = &n5;
    n5.next = &n6
    n6.next = NULL; */

       //I could do
    int i;
    node nodes[6]; //creates an array of six nodes
    for (i=0; i<5; ++1){
        nodes[i].next= &nodes[i+1];
        nodes[i].index=i;
    }
    nodes[i].next=NULL;
    nodes[i].index=i;

    // n1.next==>n2.next==>n3.next==>n4.next==>NULL
    traversell(nodes);
    printf("\n");

    //traversell(nodes);

    // Simple removal
    //n1.next = &n3;
    
    // Remove by traversal
    remove_ith_node2(3, 0, nodes); // Decide what i is
    
    // Verify that it worked
    traversell(nodes);
    printf("\n");
    
    return 0;
}
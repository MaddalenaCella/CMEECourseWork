#include <stdlib.h>
#include <stdio.h>

#include "tree.h"

tree *new_tree(const unsigned int ntax)
{
    /* this is the allocator function for the tree structure.
    requires as an argument the intended number of terminals (
        i.e. number of species the tree will hold) */
        int i = 0;
        tree *t = NULL;

        t= calloc(1, sizeof(tree));
        if (t == NULL){
            printf("Insufficient memory for requested tree size \n");
            return NULL;
        }

        t->ntax = ntax;
        t->nnodes = 2 * ntax;
        t->trnodes = calloc(t->nnodes, sizeof(node));

        //initialise the node data:
        for(i=0; i < t->nnodes; ++i){
            t-> trnodes[i].index =i;
            if (i < t->ntax){
                t->trnodes[i].tip = i +1;
            } else {
                t->trnodes[i].tip =0;
            }

            t->trnodes[i].left = NULL;
            t->trnodes[i].right = NULL;
            t->trnodes[i].anc = NULL;
        }

        if (t->trnodes == NULL){
            printf("Insufficient memory for requested tree size\n");
            free(t);
            return NULL;
        }

        return t;
}

void delete_tree(tree *t)
{

    if (t->trnodes != NULL) {

        free(t->trnodes);

        t->trnodes = NULL;

    }
    free(t);
}

//PSEUDOCODE
// if: current node is a tip:
//return;
//traverse the left node
//traverse the right node
//return;

void traverse (node *p)
{
    printf("here3\n");
    if (p->tip != 0) {
        printf("Reached a tip\n");
        return;
    }

    printf("here\n");
    traverse(p->left);
    printf("here2\n");

    traverse(p->right);
    printf("Node: %i\n", p->index);
    return;
}

void read_anctable(tree *t, int *anctable)
{
    int i=0;

    for (i=0; t->nnodes; ++i){
        //at elelemnt i in anctable
        //point the anc pointer of the ith node in the t->trnodes to anctable[i] node in t->trnodes
        //[anctable[i]] --> very ugly syntax
        //What happens to the root??
    }
}
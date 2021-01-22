#include <stdio.h>

#include "tree.h"

int main(int argc, char* argv[])
{
    int ntax=4;

    tree *t = NULL; //always initialise a new pointer to NULL

    //Creates memeory for tree with ntax tips
    //let's manually link up a tree
    // tree: ((1,2),(3,4));

    //Tree drawing:
    //1:0 2:1 3:2 4:3
    // \   /   \   /
    //  5:4     6:5
    //   \      /
    //      7:6
    
    t = new_tree(ntax);

    int anctable[] = {4,4,5,5,6,6,-1}; //do not use 0 as the last one because it would create a cyclical tree


    //I want a function to read an ancestor table
    read_anctable(t, anctable);

    //let's set up the root
    t->trnodes[t->ntax].left = &t->trnodes[t->ntax+1];
    //set up ancestor pointer here
    t->trnodes[t->ntax].right = &t->trnodes[t->ntax+2];
    //set up ancestor pointer here
    t->trnodes[t->ntax+1].left = &t->trnodes[0]; //point to tip 1
    //set up ancestor pointer here
    t->trnodes[t->ntax+1].right = &t->trnodes[1]; //point to tip 2
    //set up ancestor pointer here
    t->trnodes[t->ntax+2].left = &t->trnodes[2]; //point to tip 3
    //set up ancestor pointer here
    t->trnodes[t->ntax+2].right = &t->trnodes[3]; //point to tip 4

    //initialise root
    t->root = &t->trnodes[t->ntax];

    traverse(t->root);

    //the program does some things...


//deletes the tree memory
    delete_tree(t);
    t = NULL;

    return 0;
}
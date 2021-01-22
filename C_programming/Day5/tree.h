#ifndef _TREE_H_
#define _TREE_H_

struct node {
    struct node *left; //the left descendent pointer
    struct node *right; //the right descendent pointer
    struct node *anc; //pointer to the parent node
    int index; //0...nnodes
    int tip;//1-ntax
};

/* this is the tree struct
* the tree nodes are stored in the trnodes "array"
* indicies 0...ntax-1 are for the terminal nodes
* ntax...nnodes-1 are the internal nodes and root
*/

struct tree {
    //struct node node0;
    //struct node node1;
    //struct node node2;
    struct node *trnodes;
    struct node *root; //pointer to the root
    int ntax; //number of tips (or terminal taxa)
    int nnodes; //minimum: 2* ntax-1: rule for bin tree
};

typedef struct node node;
typedef struct tree tree;

//for memory management
tree *new_tree(const unsigned int ntax); //declares that the number will not get changed and unsigned means that number has to be non negative
void delete_tree(tree *t)
void traverse(ndode* p);
void read_anctable(tree *t, int *anctable);
#endif
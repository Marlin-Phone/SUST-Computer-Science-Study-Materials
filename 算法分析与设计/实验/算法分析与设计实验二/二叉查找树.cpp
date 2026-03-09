#define _CRT_SECURE_NO_WARNINGS
#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>

typedef int Status;
typedef int TElemType;
typedef struct BiTNode {
    TElemType data;
    struct BiTNode* lchild, * rchild;
} BiTNode, * BiTree;

Status CreateBiTree(BiTree& T) {
    TElemType e;
    scanf("%d", &e);
    if (e == 0) T = NULL;
    else {
        T = (BiTree)malloc(sizeof(BiTNode));
        if (!T) exit(1);
        T->data = e;
        CreateBiTree(T->lchild);
        CreateBiTree(T->rchild);
    }
    return 1;
}

void InorderTraversal(BiTree& T) {
    if (T != NULL) {
        InorderTraversal(T->lchild);
        printf(" %d", T->data);
        InorderTraversal(T->rchild);
    }
}

int main() {
    BiTree T;
    CreateBiTree(T);
    InorderTraversal(T);
    return 0;
}

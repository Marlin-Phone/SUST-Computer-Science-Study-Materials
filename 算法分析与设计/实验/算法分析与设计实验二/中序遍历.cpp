#define _CRT_SECURE_NO_WARNINGS
#include <stdlib.h>
#include <stdio.h>
#include <iostream>

typedef int ElementType; // 将 ElementType 改为 int 类型
typedef struct TNode* Position;
typedef Position BinTree;
struct TNode {
    ElementType Data;
    BinTree Left;
    BinTree Right;
} BinTNode;

int CreateBinTree(BinTree& T) {
    int e;
    scanf("%d", &e);
    if (e == 0) T = NULL;
    else {
        T = (BinTree)malloc(sizeof(BinTNode));
        if (!T) exit(0);
        T->Data = e;
        CreateBinTree(T->Left);
        CreateBinTree(T->Right);
    }
    return 1;
}

void InorderTraversal(BinTree BT) {
    if (BT != NULL) {
        InorderTraversal(BT->Left);
        printf(" %d", BT->Data); // 输出整数
        InorderTraversal(BT->Right);
    }
}

int main() {
    BinTree BT;
    CreateBinTree(BT);
    printf("Inorder:");
    InorderTraversal(BT);
    printf("\n");
    return 0;
}

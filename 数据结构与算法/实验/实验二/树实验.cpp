#include <stdio.h>
#include <stdlib.h>

// 定义一个表示二叉树节点的结构体
typedef struct Node {
    int value;
    struct Node* left;
    struct Node* right;
} Node;

// 创建一个新的节点
Node* newNode(int value) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->value = value;
    node->left = NULL;
    node->right = NULL;
    return node;
}

// 定义一个用于中序遍历二叉树的函数
void PrintTree(Node* root) {
    if (root != NULL) {
        PrintTree(root->left);
        printf("%d ", root->value);
        PrintTree(root->right);
    }
}

// 定义一个计算二叉树深度的函数（分治法） 
int TreeDepth(Node* root) {
    if (root == NULL) {
        return 0;
    } else {
        int left_depth = TreeDepth(root->left);	//求左子树深度 
        int right_depth = TreeDepth(root->right);

        if (left_depth > right_depth) {	//得到左、右子树深度较大的值的深度 
            return left_depth + 1;
        } else {
            return right_depth + 1;
        }
    }
}

// 定义一个计算二叉树叶子节点数的函数（分治法） 
int Leaf(Node* root) {
    if (root == NULL) {
        return 0;
    } else if (root->left == NULL && root->right == NULL) {
        return 1;
    } else {
        return Leaf(root->left) + Leaf(root->right);
    }
}

// 定义一个根据先序序列和中序序列恢复二叉树的函数
Node* buildTree(int* preorder, int preStart, int preEnd, int* inorder, int inStart, int inEnd) {
    if (preStart > preEnd || inStart > inEnd) {
        return NULL;
    }

    Node* root = newNode(preorder[preStart]);

    int inRootIndex = 0;
    for (int i = inStart; i <= inEnd; i++) {
        if (inorder[i] == root->value) {
            inRootIndex = i;
            break;
        }
    }

    root->left = buildTree(preorder, preStart + 1, preStart + inRootIndex - inStart, inorder, inStart, inRootIndex - 1);
    root->right = buildTree(preorder, preStart + inRootIndex - inStart + 1, preEnd, inorder, inRootIndex + 1, inEnd);

    return root;
}

// 定义一个计算二叉树中节点的度的函数
int Degree(Node* root) {
    if (root == NULL) {
        return 0;
    }

    int degree = 0;
    if (root->left != NULL) {
        degree++;
    }
    if (root->right != NULL) {
        degree++;
    }

    int left_degree = Degree(root->left);
    int right_degree = Degree(root->right);

     int max_degree = degree;
    if (left_degree > max_degree) {
        max_degree = left_degree;
    }
    if (right_degree > max_degree) {
        max_degree = right_degree;
    }

    return max_degree;
}

// 定义一个计算二叉树总节点数的函数
int Nodes(Node* root) {
    if (root == NULL) {
        return 0;
    } else {
        return Nodes(root->left) + Nodes(root->right) + 1;
    }
}

int main() {
    int preorder[] = {1, 2, 4, 5, 3, 6, 7};
    int inorder[] = {4, 2, 5, 1, 6, 3, 7};

    Node* root = buildTree(preorder, 0, 6, inorder, 0, 6);

    printf("恢复的二叉树的中序遍历结果：\n");
    PrintTree(root);
    printf("\n二叉树的深度：%d\n", TreeDepth(root));
    printf("二叉树的叶子节点数：%d\n", Leaf(root));
    printf("二叉树的最大度：%d\n", Degree(root));
    printf("二叉树的总节点数：%d\n", Nodes(root));

    return 0;
}


//变量三 -- 链地址法
 
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_TABLE_SIZE 100000  

// 链表节点结构体
typedef struct Node {
    int key;
    struct Node *next;
} Node;

// 散列表结构体
typedef struct {
    Node **table; // 散列表数组，存储链表头指针
    int size;     // 散列表大小
    int p;        // 散列函数的除数
} HashTable;

// 初始化散列表
void initHashTable(HashTable *h, int size, int p) {
    h->size = size;
    h->p = p;
    h->table = (Node **)malloc(sizeof(Node *) * size);
    for (int i = 0; i < size; i++) {
        h->table[i] = NULL; // 初始化为空链表
    }
}

// 散列函数
int hash(int key, int p, int size) {
    return key % p % size;
}

// 插入函数（链地址法）
void insert(HashTable *h, int key) {
    int index = hash(key, h->p, h->size);
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->key = key;
    newNode->next = h->table[index];	//头插法插入新结点 
    h->table[index] = newNode;
}

// 查找函数
int search(HashTable *h, int key) {
    int index = hash(key, h->p, h->size);
    Node *temp = h->table[index];
    int count = 0; // 计数查找长度
    while (temp != NULL) {
        count++;
        if (temp->key == key) {
            return count; // 找到则返回查找长度
        }
        temp = temp->next;
    }
    return count; // 未找到也返回查找长度
}

// 生成正整数集合
void generateSet(int *set, int size) {
    srand(time(NULL));
    for (int i = 0; i < size; i++) {	 
        set[i] = rand() % MAX_TABLE_SIZE; // 生成随机正整数
    }
}

int main() {
	float sum = 0;
	int count = 100;

begin: 
    HashTable h;
    int setSize = 10000; 	// 变量一 -- 散列表的长度m
    int p = 10000; 	// 变量二 -- 散列函数的除数p
    int *set = (int *)malloc(sizeof(int) * setSize);
    
    // 生成正整数集合
    generateSet(set, setSize / 10);	//变量四 -- 已存储的元素数与散列表大小的比例
    
    // 初始化散列表
    initHashTable(&h, setSize, p);
    
    // 插入正整数到散列表
    for (int i = 0; i < setSize; i++) {
        insert(&h, set[i]);
    }
    
    // 测量平均查找长度
    double avgLength = 0;
    for(int i = 0; i < setSize; i++) {
        avgLength += search(&h, set[i]);
    }
    avgLength /= setSize;

	sum = sum + avgLength;    
    while(count > 0){
    	count--; 
    	goto begin; 
	}
    
    printf("平均查找长度: %f\n", sum/100);
    
    return 0;
}


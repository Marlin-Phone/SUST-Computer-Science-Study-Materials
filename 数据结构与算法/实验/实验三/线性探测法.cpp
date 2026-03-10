//变量三 -- 线性探测法
 
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_TABLE_SIZE 100000

// 散列表结构体
typedef struct {
    int *table; // 散列表数组
    int size;   // 散列表大小
	int p;
} HashTable;

// 初始化散列表
void initHashTable(HashTable *h, int size, int p) {
    h->size = size;
    h->p = p;
    h->table = (int *)malloc(sizeof(int) * size);
    for(int i = 0; i < size; i++) {
        h->table[i] = -1; // 使用-1表示空位
    }
}

// 散列函数
int hash(int key, int p, int size) {
    return key %p % size;
}

// 插入函数（线性探测法）
void insert(HashTable *h, int key) {
    int index = hash(key, h->p, h->size);
    while(h->table[index] != -1) {
        index = (index + 1) % h->size; // 线性探测
    }
    h->table[index] = key;
}

// 查找函数
int search(HashTable *h, int key) {
    int index = hash(key,h->p, h->size);
    int count = 0; // 计数查找长度
    while(h->table[index] != -1) {
        count++;
        if(h->table[index] == key) {
            return count; // 找到则返回查找长度
        }
        index = (index + 1) % h->size; // 线性探测
    }
    return count; // 未找到也返回查找长度
}

// 生成正整数集合
void generateSet(int *set, int size) {
    srand(time(NULL));
    for(int i = 0; i < size; i++) {	 
        set[i] = rand() % MAX_TABLE_SIZE; // 生成随机正整数
    }
}

int main() {
	float sum = 0;
	int count = 5;

begin:	
    HashTable h;
    int setSize = 10000;	// 变量一 -- 散列表的长度m
	int p = 100; 	// 变量二 -- 散列函数的除数p	
    int *set = (int *)malloc(sizeof(int) * setSize);
    
    // 生成正整数集合
    generateSet(set, setSize);	//变量四 -- 已存储的元素数与散列表大小的比例
    
    // 初始化散列表
    initHashTable(&h, setSize, p);
    
    // 插入正整数到散列表
    for(int i = 0; i < setSize; i++) {
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
	
    printf("5次查找的平均查找长度: %f\n", sum / 5);
        
    return 0;
}


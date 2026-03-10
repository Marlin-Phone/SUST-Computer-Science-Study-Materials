//顺序表实验 text

#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define MAXSIZE 500000

typedef struct{
	int data[MAXSIZE];
	int length;
}SqList;

void ShowMenu(); 
void PrintElem(SqList* L);
void CreatElem(SqList* L);
void GetElem(SqList* L,int i);
void IncertElem(SqList* L,int i,int e);
void DeleteElem(SqList* L,int i);
void CreatRandElem(SqList* L);
void exit();
void T_GetElem(SqList *L); 
void T_IncertElem(SqList *L);
void T_DeleteElem(SqList *L);

int main(){
	SqList L;
	L.length=0;
	int choice;
	while(1){
		ShowMenu();
		
		scanf("%d",&choice);
		
		switch(choice){
			case 0: PrintElem(&L); break; 
			case 1: CreatElem(&L); break;
			case 2: CreatElem(&L); break;
			case 3: T_GetElem(&L); break;
			case 4: T_IncertElem(&L); break;
			case 5: T_DeleteElem(&L); break;
			case 6: CreatRandElem(&L); break; 
			case 7: exit(); break;
			default: printf("输入错误\n");
		}
	}
	
	return 0;	
}

void ShowMenu(){
	printf("请输入你要进行的操作：\n");
	printf("0.输出该线性表\n");
	printf("1.创建一个空的线性表\n");
	printf("2.销毁一个线性表\n");
	printf("3.在线性表中查找给定位序的元素\n");
	printf("4.在线性表中给定位置插入给定元素\n");
	printf("5.删除线性表中特定位置的元素\n");
	printf("6.创建一个长度为10000的随机线性表(0-100)\n");
	printf("7.退出系统\n");
} 
void PrintElem(SqList *L){
	if(L->length==0) printf("还未创建表 或 还未给表添加元素！");
	for(int i=0;i<L->length;i++){
		printf("%3d",L->data[i]);
	}
	printf("\n");
	system("pause");
	system("cls");
}
void CreatElem(SqList *L){
	L->length=0;
	printf("执行成功！\n"); 
	system("pause");
	system("cls");
}
void GetElem(SqList* L,int i){
	if(i>L->length||i<=0){
		printf("查询错误，请输入位于表区间内的值！\n");
		system("pause");
		system("cls");		
		return;
	} 
}
void IncertElem(SqList* L,int i,int e){
	int j;
	if(i>L->length+1||i<=0){
		printf("插入错误，请输入位于表区间内的值！\n");
		return; 
	}
	for(j=L->length;j>=i-1;j--){
		L->data[j+1]=L->data[j];
	}
	L->data[i-1]=e;
	L->length++;
}
void DeleteElem(SqList* L,int i){
	int j;
	if(i>L->length||i<=0){
		printf("删除错误，请输入位于表区间内的值！\n");
		return;
	}
	for(j=i;j<L->length;j++){
		L->data[j-1]=L->data[j];
	}
	L->length--;
}
void CreatRandElem(SqList *L){
	for(int i=0;i<10000;i++){
		L->data[i]=rand()%100+0;
		L->length++;
	} 
	printf("创建完成！\n"); 
	system("pause");
	system("cls");

}
void exit(){
	printf("退出成功，欢迎下次使用！\n");
	exit(0); 
}
void T_GetElem(SqList* L){
	double time;
	int i;
	printf("你要查询的位置为：\n");
	scanf("%d",&i); 	
	clock_t begin=clock();
	for(int j=0;j<100000;j++){
		GetElem(L,i);		
	}
	clock_t end=clock();
	time=1.0*(end-begin)/CLOCKS_PER_SEC;
	printf("运行100000次耗费的时间为：%lf s\n",time);
	system("pause");
	system("cls");
}
void T_IncertElem(SqList *L){
	double time;
	int i,e;
	printf("你要插入的位置和元素分别为：\n");
	scanf("%d%d",&i,&e);
	clock_t begin=clock();
	for(int j=0;j<100000;j++){
	IncertElem(L,i,e);		
	} 
	clock_t end=clock();
	time=1.0*(end-begin)/CLOCKS_PER_SEC;
	printf("运行100000次耗费的时间为：%lf s\n",time);
	system("pause");
	system("cls");
}
void T_DeleteElem(SqList *L){
	double time;
	int i;
	printf("你要删除的位置为：\n");
	scanf("%d",&i);
	clock_t begin=clock();
	for(int j=0;j<100000;j++){
	DeleteElem(L,i);		
	} 
	clock_t end=clock();
	time=1.0*(end-begin)/CLOCKS_PER_SEC;
	printf("运行100000次耗费的时间为：%lf s\n",time);
	system("pause");
	system("cls");
}

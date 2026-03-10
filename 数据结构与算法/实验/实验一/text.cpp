//链表实验 text

#include<stdio.h>
#include<stdlib.h>
#include<time.h> 
#define MAXSIZE 200100

typedef struct Node{
	int data;
	struct Node *Next;
}Node,*LinkList;

void ShowMenu();
void CreatListHead(LinkList *L);
void ClearList(LinkList *L);
void T_GetElem(LinkList L);
int GetElem(LinkList L,int i,int *e);
void T_IncertElem(LinkList *L);
int IncertElem(LinkList *L,int i,int e);
void T_DeleteElem(LinkList *L);
int DeleteElem(LinkList *L,int i);
void CreatRandElem(LinkList *L);
void exit(); 
void PrintElem(LinkList L);

int main(){
	int choice;
	Node* L=(Node*)malloc(sizeof(Node));
	L->Next=NULL;
	
	while(1){
		ShowMenu();
		
		scanf("%d",&choice);
		
		switch(choice){
			case 0: PrintElem(L); break; 
			case 1: CreatListHead(&L); break;
			case 2: ClearList(&L); break;
			case 3: T_GetElem(L); break;
			case 4: T_IncertElem(&L); break;
			case 5: T_DeleteElem(&L); break;
			case 6: CreatRandElem(&L); break; 
			case 7: exit(); break;
			default: printf("输入错误\n");
		}
	} 
}

void ShowMenu(){
	printf("请输入你要进行的操作：\n");
	printf("0.输出该链表\n");
	printf("1.创建一个空的链表\n");
	printf("2.销毁一个链表\n");
	printf("3.在链表中查找给定位序的元素\n");
	printf("4.在链表中给定位置插入给定元素\n");
	printf("5.删除链表中特定位置的元素\n");
	printf("6.创建一个长度为10000的随机链表(0-100)\n");
	printf("7.退出系统\n");
} 
void CreatListHead(LinkList *L){//1.创建空链表 
	LinkList p;
	*L=(LinkList)malloc(sizeof(Node));
	(*L)->Next=NULL;
	printf("创建成功！\n");
	system("pause");
	system("cls");
}
void ClearList(LinkList *L){//2.销毁链表 
	LinkList p,q;
	p=(*L)->Next;
	while(p){
		q=p->Next;
		free(p);
		p=q;
	}
	(*L)->Next=NULL;
	printf("销毁成功！\n");
	system("pause");
	system("cls");
}
void T_GetElem(LinkList L){//3.查找元素 
	int i,status;
	int e;
	double time;
	printf("你要查询的位置为：\n");
	scanf("%d",&i);
	clock_t begin=clock();
	for(int j=0;j<100000;j++){
		status=GetElem(L,i,&e);	
	} 
	clock_t end=clock();
	time=1.0*(end-begin)/CLOCKS_PER_SEC;
	if(status==0){
		printf("该元素为：%d\n",e);
		printf("运行100000次耗费的时间为：%lf s\n",time);
		system("pause");
		system("cls");
	}
}
int GetElem(LinkList L,int i,int *e){//3.1查找元素 
	int j;
	LinkList p;
	p=L->Next;
	j=1;
	while(p&&j<i){
		p=p->Next;
		j++;
	}
	if(!p||j>i){
		printf("查询错误，请输入位于表区间内的值！\n");	
		system("pause");
		system("cls");
		return -1;
	} 
	*e=p->data;
	return 0;
}
void T_IncertElem(LinkList *L){//4插入元素 
	int i,status;
	int e;
	double time;
	printf("你要插入的位置和元素分别为：\n");
	scanf("%d%d",&i,&e);
	clock_t begin=clock();
	for(int j=0;j<100000;j++){
		status=IncertElem(L,i,e);		
	}
	clock_t end=clock();
	time=1.0*(end-begin)/CLOCKS_PER_SEC;
	if(status==0){
		printf("插入成功！"); 
		printf("运行100000次耗费的时间为：%lf s\n",time);
		system("pause");
		system("cls");
	}else{
		printf("插入错误，请输入位于表区间内的值！\n");
	} 
}
int IncertElem(LinkList *L,int i,int e){//4.1插入元素 
	int j;
	LinkList p,s;
	p=*L;
	j=1;
	while(p&&j<i){
		p=p->Next;
		j++;
	}
	if(!p||j>i){
		return -1;
	}
	s=(LinkList)malloc(sizeof(Node));
	s->data=e;
	s->Next=p->Next;
	p->Next=s;
	return 0;
}
void T_DeleteElem(LinkList *L){//5删除元素 
	int i,status;
	double time;
	printf("你要删除的位置为：\n");
	scanf("%d",&i);
	clock_t begin=clock();
	for(int j=0;j<100000;j++){
		status=DeleteElem(L,i);	
	} 
	clock_t end=clock();
	time=1.0*(end-begin)/CLOCKS_PER_SEC;
	if(status==0){
		printf("删除成功！");
		printf("运行100000次耗费的时间为：%lf s\n",time);
		system("pause");
		system("cls");
	}else{
		printf("删除错误，请输入位于表区间内的值！\n");
	} 
}
int DeleteElem(LinkList *L,int i){//5.1删除元素 
	int j;
	LinkList p,q;
	p=*L;
	j=1;
	while(p&&j<i){
		p=p->Next;
		j++;
	}
	if(!p||j>i){
		return -1;
	}
	q=p->Next;
	p->Next=p->Next->Next;
	return 0;
}
void CreatRandElem(LinkList *L){//6头插法创建随机链表 
	LinkList p;
	int i;
	*L=(LinkList)malloc(sizeof(Node));
	(*L)->Next=NULL;
	for(i=0;i<10000;i++){
		p=(LinkList)malloc(sizeof(Node));
		p->data=rand()%100+0;
		p->Next=(*L)->Next;
		(*L)->Next=p;
	}
	printf("创建完成！\n"); 
	system("pause");
	system("cls");
}
void exit(){//7退出程序 
	printf("退出成功，欢迎下次使用！\n");
	exit(0); 
}
void PrintElem(LinkList L){
	LinkList p;
	p=L;
	p=p->Next;
	if(p==NULL){
		printf("还未创建表 或 还未给表添加元素！\n");
	}
	while(p!=NULL){
		printf("%3d",p->data);
		p=p->Next;
	}
	printf("\n"); 
	system("pause");
	system("cls");
}

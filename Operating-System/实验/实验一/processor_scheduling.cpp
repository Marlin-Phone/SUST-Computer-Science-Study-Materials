// 使用C++11标准编译
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <string>
#include <algorithm>
using namespace std;

// 进程控制块(PCB)结构体
struct PCB {
    string name;      // 进程名
    int time;         // 要求运行时间
    int priority;     // 优先数
    char status;      // 状态(R:就绪, E:结束)
    PCB* next;        // 指向下一个进程的指针
    
    PCB(string n, int t, int p) : name(n), time(t), priority(p), status('R'), next(nullptr) {}
};

// 就绪队列管理类
class ReadyQueue {
private:
    PCB* head;

public:
    ReadyQueue() : head(nullptr) {}
    
    // 按优先数排序插入进程
    void insert(PCB* process) {
        if (!head || process->priority > head->priority) {
            process->next = head;
            head = process;
        } else {
            PCB* current = head;
            while (current->next && current->next->priority >= process->priority) {
                current = current->next;
            }
            process->next = current->next;
            current->next = process;
        }
    }
    
    // 获取队首进程
    PCB* getHead() const {
        return head;
    }
    
    // 移除指定进程
    void remove(PCB* process) {
        if (!head) return;
        
        if (head == process) {
            head = head->next;
            return;
        }
        
        PCB* current = head;
        while (current->next && current->next != process) {
            current = current->next;
        }
        if (current->next) {
            current->next = current->next->next;
        }
    }
    
    // 显示当前队列状态
    void display() const {
        cout << "\n当前就绪队列:" << endl;
        cout << "进程名\t运行时间\t优先数\t状态" << endl;
        PCB* current = head;
        while (current) {
            cout << current->name << "\t" << current->time << "\t\t" 
                 << current->priority << "\t" << current->status << endl;
            current = current->next;
        }
    }
    
    // 检查队列是否为空
    bool isEmpty() const {
        return head == nullptr;
    }
};

// 处理器调度核心算法
void schedule(ReadyQueue& queue) {
    cout << "===== 开始处理器调度模拟 =====" << endl;
    int cycle = 1;
    
    while (!queue.isEmpty()) {
        PCB* current = queue.getHead();
        
        cout << "\n【调度周期 " << cycle++ << "】" << endl;
        cout << "选中进程: " << current->name << endl;
        
        // 模拟进程运行
        current->priority--;
        current->time--;
        
        // 更新状态
        if (current->time <= 0) {
            current->status = 'E';
            queue.remove(current);
            cout << "进程 " << current->name << " 运行结束" << endl;
        } else {
            queue.remove(current);
            queue.insert(current);
        }
        
        queue.display();
    }
    
    cout << "\n===== 所有进程已执行完毕 =====" << endl;
}

int main() {
    // 设置随机种子
    srand(time(0));
    
    ReadyQueue queue;
    vector<PCB*> processes;
    
    // 创建5个进程(P1-P5)
    for (int i = 1; i <= 5; i++) {
        string name = "P" + to_string(i);
        // 随机生成运行时间(1-5)和优先数(1-10)
        int time = rand() % 5 + 1;
        int priority = rand() % 10 + 1;
        
        PCB* p = new PCB(name, time, priority);
        processes.push_back(p);
        queue.insert(p);
    }
    
    // 显示初始状态
    cout << "===== 初始进程状态 =====" << endl;
    cout << "进程名\t运行时间\t优先数\t状态" << endl;
    for (PCB* p : processes) {
        cout << p->name << "\t" << p->time << "\t\t" 
             << p->priority << "\t" << p->status << endl;
    }
    
    // 执行调度
    schedule(queue);
    
    // 释放内存
    for (PCB* p : processes) {
        delete p;
    }
    
    return 0;
}
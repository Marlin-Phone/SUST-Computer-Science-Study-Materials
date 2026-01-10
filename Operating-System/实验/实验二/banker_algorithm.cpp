#include <iostream>
#include <vector>
#include <string>
using namespace std;

class BankerAlgorithm {
private:
    int numProcesses;    // 进程数量
    int numResources;    // 资源种类数量
    vector<int> available;     // 可利用资源向量
    vector<vector<int>> max;  // 最大需求矩阵
    vector<vector<int>> allocation;  // 分配矩阵
    vector<vector<int>> need;  // 需求矩阵

public:
    // 输入系统资源信息
    void inputResources() {
        cout << "请输入资源种类数量: ";
        cin >> numResources;
        
        available.resize(numResources);
        cout << "请输入每种资源的可用数量: ";
        for (int i = 0; i < numResources; i++) {
            cin >> available[i];
        }
    }

    // 输入进程信息
    void inputProcesses() {
        cout << "请输入进程数量: ";
        cin >> numProcesses;
        
        // 初始化矩阵
        max.resize(numProcesses, vector<int>(numResources));
        allocation.resize(numProcesses, vector<int>(numResources));
        need.resize(numProcesses, vector<int>(numResources));
        
        // 输入每个进程的最大需求
        cout << "\n请输入每个进程对每种资源的最大需求:" << endl;
        for (int i = 0; i < numProcesses; i++) {
            cout << "进程 P" << i << ": ";
            for (int j = 0; j < numResources; j++) {
                cin >> max[i][j];
            }
        }
        
        // 输入每个进程已分配的资源
        cout << "\n请输入每个进程已分配的资源数量:" << endl;
        for (int i = 0; i < numProcesses; i++) {
            cout << "进程 P" << i << ": ";
            for (int j = 0; j < numResources; j++) {
                cin >> allocation[i][j];
            }
        }
        
        // 计算需求矩阵
        calculateNeed();
    }

    // 计算需求矩阵
    void calculateNeed() {
        for (int i = 0; i < numProcesses; i++) {
            for (int j = 0; j < numResources; j++) {
                need[i][j] = max[i][j] - allocation[i][j];
            }
        }
    }

    // 显示当前状态
    void displayState() {
        cout << "\n当前系统状态:" << endl;
        cout << "可用资源: ";
        for (int i = 0; i < numResources; i++) {
            cout << available[i] << " ";
        }
        cout << endl;

        cout << "\n最大需求矩阵:" << endl;
        for (int i = 0; i < numProcesses; i++) {
            cout << "P" << i << ": ";
            for (int j = 0; j < numResources; j++) {
                cout << max[i][j] << " ";
            }
            cout << endl;
        }

        cout << "\n分配矩阵:" << endl;
        for (int i = 0; i < numProcesses; i++) {
            cout << "P" << i << ": ";
            for (int j = 0; j < numResources; j++) {
                cout << allocation[i][j] << " ";
            }
            cout << endl;
        }

        cout << "\n需求矩阵:" << endl;
        for (int i = 0; i < numProcesses; i++) {
            cout << "P" << i << ": ";
            for (int j = 0; j < numResources; j++) {
                cout << need[i][j] << " ";
            }
            cout << endl;
        }
    }

    // 安全性算法
    bool isSafe() {
        vector<int> work = available;
        vector<bool> finish(numProcesses, false);
        vector<int> safeSequence;

        cout << "\n执行安全性算法:" << endl;

        while (true) {
            bool found = false;
            for (int i = 0; i < numProcesses; i++) {
                if (!finish[i]) {
                    bool canExecute = true;
                    for (int j = 0; j < numResources; j++) {
                        if (need[i][j] > work[j]) {
                            canExecute = false;
                            break;
                        }
                    }

                    if (canExecute) {
                        cout << "进程 P" << i << " 可以执行" << endl;
                        for (int j = 0; j < numResources; j++) {
                            work[j] += allocation[i][j];
                        }
                        finish[i] = true;
                        safeSequence.push_back(i);
                        found = true;
                        break;
                    }
                }
            }

            if (!found) {
                break;
            }
        }

        bool isSafe = true;
        cout << "安全序列: ";
        for (int i = 0; i < numProcesses; i++) {
            if (!finish[i]) {
                isSafe = false;
                break;
            }
            cout << "P" << safeSequence[i];
            if (i < numProcesses - 1) cout << " -> ";
        }
        cout << endl;

        if (isSafe) {
            cout << "系统处于安全状态" << endl;
        } else {
            cout << "系统处于不安全状态" << endl;
        }

        return isSafe;
    }

    // 银行家算法核心
    void requestResources(int processId) {
        vector<int> request(numResources);
        cout << "请输入进程 P" << processId << " 的资源请求:" << endl;
        for (int i = 0; i < numResources; i++) {
            cout << "请求资源 R" << i << " 的数量: ";
            cin >> request[i];
        }

        // 检查请求是否合法
        for (int i = 0; i < numResources; i++) {
            if (request[i] > need[processId][i]) {
                cout << "错误: 请求的资源数量超过最大需求" << endl;
                return;
            }
            if (request[i] > available[i]) {
                cout << "错误: 系统没有足够的可用资源" << endl;
                return;
            }
        }

        // 试探性分配
        cout << "\n试探性分配..." << endl;
        vector<int> tempAvailable = available;
        vector<vector<int>> tempAllocation = allocation;
        vector<vector<int>> tempNeed = need;

        for (int i = 0; i < numResources; i++) {
            tempAvailable[i] -= request[i];
            tempAllocation[processId][i] += request[i];
            tempNeed[processId][i] -= request[i];
        }

        // 保存原始状态
        vector<int> originalAvailable = available;
        vector<vector<int>> originalAllocation = allocation;
        vector<vector<int>> originalNeed = need;

        // 更新为试探状态
        available = tempAvailable;
        allocation = tempAllocation;
        need = tempNeed;

        // 检查安全性
        if (isSafe()) {
            cout << "\n资源分配成功!" << endl;
        } else {
            cout << "\n资源分配会导致不安全状态，分配失败!" << endl;
            // 恢复原始状态
            available = originalAvailable;
            allocation = originalAllocation;
            need = originalNeed;
        }
    }

    // 主运行函数
    void run() {
        cout << "=== 银行家算法模拟程序 ===" << endl;
        
        inputResources();
        inputProcesses();
        
        while (true) {
            displayState();
            
            cout << "\n选择操作:" << endl;
            cout << "1. 检查系统安全性" << endl;
            cout << "2. 请求资源" << endl;
            cout << "3. 退出程序" << endl;
            cout << "请输入选择: ";
            
            int choice;
            cin >> choice;
            
            switch (choice) {
                case 1:
                    isSafe();
                    break;
                case 2: {
                    int processId;
                    cout << "请输入请求资源的进程ID (0-" << numProcesses-1 << "): ";
                    cin >> processId;
                    if (processId >= 0 && processId < numProcesses) {
                        requestResources(processId);
                    } else {
                        cout << "无效的进程ID!" << endl;
                    }
                    break;
                }
                case 3:
                    cout << "程序结束" << endl;
                    return;
                default:
                    cout << "无效选择!" << endl;
            }
        }
    }
};

int main() {
    BankerAlgorithm banker;
    banker.run();
    return 0;
}
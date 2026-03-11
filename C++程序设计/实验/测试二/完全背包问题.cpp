#include <iostream>
#include <vector>

// 定义背包容量和物品数量
const int MAX_CAPACITY = 10;
const int NUM_ITEMS = 5;

// 定义物品的重量和价值
int weights[NUM_ITEMS] = {2, 3, 4, 5, 6};
int values[NUM_ITEMS] = {10, 20, 30, 40, 50};

// 定义动态规划表
int dp[MAX_CAPACITY + 1];

// 初始化动态规划表
void initDP() {
    for (int i = 0; i <= MAX_CAPACITY; i++) {
        dp[i] = 0;
    }
}

// 计算完全背包问题的解
void knapsack() {
    for (int i = 1; i <= MAX_CAPACITY; i++) {
        for (int j = 0; j < NUM_ITEMS; j++) {
            if (weights[j] <= i) {
                dp[i] = std::max(dp[i], dp[i - weights[j]] + values[j]);
            }
        }
    }
}

// 打印完全背包问题的解
void printSolution() {
    std::cout << "最大价值：" << dp[MAX_CAPACITY] << std::endl;
    int i = MAX_CAPACITY;
    while (i > 0) {
        for (int j = 0; j < NUM_ITEMS; j++) {
            if (weights[j] <= i && dp[i] == dp[i - weights[j]] + values[j]) {
                std::cout << "物品" << j << "被选中，重量：" << weights[j] << "，价值：" << values[j] << std::endl;
                i -= weights[j];
                break;
            }
        }
    }
}

int main() {
    initDP();
    knapsack();
    printSolution();
    return 0;
}

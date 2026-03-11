//01背包问题
#include <iostream>
#include <vector>

// 定义背包容量和物品数量
const int MAX_CAPACITY = 10;
const int NUM_ITEMS = 5;

// 定义物品的重量和价值
int weights[NUM_ITEMS] = {2, 3, 4, 5, 6};
int values[NUM_ITEMS] = {10, 20, 30, 40, 50};

// 定义动态规划表
int dp[MAX_CAPACITY + 1][NUM_ITEMS + 1];

// 初始化动态规划表
void initDP() {
    for (int i = 0; i <= MAX_CAPACITY; i++) {
        for (int j = 0; j <= NUM_ITEMS; j++) {
            dp[i][j] = 0;
        }
    }
}

// 计算0-1背包问题的解
void knapsack() {
    for (int i = 1; i <= MAX_CAPACITY; i++) {
        for (int j = 1; j <= NUM_ITEMS; j++) {
            if (weights[j - 1] > i) {
                dp[i][j] = dp[i][j - 1];
            } else {
                dp[i][j] = std::max(dp[i][j - 1], dp[i - weights[j - 1]][j - 1] + values[j - 1]);
            }
        }
    }
}

// 打印0-1背包问题的解
void printSolution() {
    std::cout << "最大价值：" << dp[MAX_CAPACITY][NUM_ITEMS] << std::endl;
    int i = MAX_CAPACITY, j = NUM_ITEMS;
    while (j > 0) {
        if (dp[i][j] != dp[i][j - 1]) {
            std::cout << "物品" << j << "被选中，重量：" << weights[j - 1] << "，价值：" << values[j - 1] << std::endl;
            i -= weights[j - 1];
        }
        j--;
    }
}

int main() {
    initDP();
    knapsack();
    printSolution();
    return 0;
}

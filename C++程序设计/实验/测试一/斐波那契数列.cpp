#include <iostream>
using namespace std;

int fibonacci(int n) {
    if (n <= 0) {
        std::cerr << "输入有误" << std::endl;
        return -1; // 或抛出异常
    }
    else if (n == 1) {
        return 0;
    }
    else if (n == 2) {
        return 1;
    }
    else {
        int a = 0, b = 1, result;
        for (int i = 3; i <= n; i++) {
            result = a + b;
            a = b;
            b = result;
        }
        return result;
    }
}

int main() {
    cout << "第10个斐波那契数为:" << endl;
    cout << fibonacci(10) << endl;
    return 0;
}

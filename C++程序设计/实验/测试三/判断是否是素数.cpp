#include <iostream>

bool isPrime(int num) {
    if (num <= 1) {
        return false;
    }
    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) {
            return false;
        }
    }
    return true;
}

int main() {
    int num;
    std::cout << "请输入一个数：";
    std::cin >> num;
    if (isPrime(num)) {
        std::cout << num << "是素数" << std::endl;
    } else {
        std::cout << num << "不是素数" << std::endl;
    }
    return 0;
}

#include <iostream>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int lcm(int a, int b) {
    return a * b / gcd(a, b);
}

int main() {
    int a, b;
    std::cout << "请输入两个数：";
    std::cin >> a >> b;
    int g = gcd(a, b);
    int l = lcm(a, b);
    std::cout << "最大公因数：" << g << std::endl;
    std::cout << "最小公倍数：" << l << std::endl;
    return 0;
}

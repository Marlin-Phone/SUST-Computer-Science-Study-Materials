#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <algorithm>
#include <set>
using namespace std;

int father[1000000];
set<int> st;

void init() {
    for (int i = 0; i < 1000000; i++) father[i] = i;
}

int findFather(int i) {
    if (father[i] == i) return i;
    else {
        father[i] = findFather(father[i]); // 路径压缩
        return father[i];
    }
}

void Union(int a, int b) {
    int Fa = findFather(a);
    int Fb = findFather(b);
    if (Fa != Fb) {
        father[Fa] = Fb;
    }
}

int main() {
    int a, b, sum = 0;
    bool show[1000000] = { 0 };
    init();
    while (true) {
        scanf("%d %d", &a, &b);
        if (a == -1 && b == -1) break;
        Union(a, b);
        st.insert(a);
        st.insert(b);
    }
    for (set<int>::iterator it = st.begin(); it != st.end(); it++)
        if (findFather(*it) == *it) sum++; // 使用路径压缩
    cout << sum;
    return 0;
}

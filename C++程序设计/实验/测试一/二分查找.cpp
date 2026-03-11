#include <iostream>
using namespace std;
//二分查找
int binarySearch(int arr[], int n, int target) {
    int left = 0;
    int right = n - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] == target) {
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return -1; // 未找到
}

int main() {
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    int n = sizeof(arr) / sizeof(arr[0]);
    int target = 5;
    int result = binarySearch(arr, n, target);
    if (result != -1) {
        printf("找到目标元素，索引为：%d\n", result);
    } else {
        printf("未找到目标元素\n");
    }
    return 0;
}

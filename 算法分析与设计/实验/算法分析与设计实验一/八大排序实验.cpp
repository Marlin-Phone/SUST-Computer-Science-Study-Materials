// 八大排序实验.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。

#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <vector>
#include <algorithm>
#include <random>
#include <chrono>
#include <fstream>
//#include <bits/stdc++.h>
using namespace std;

void select_sort(int nums[], int n); //选择排序
void insert_sort(int nums[], int n); //插入排序
void bubble_sort(int nums[], int n); //冒泡排序
void quick_sort(int nums[], int left, int right); //快速排序
void heap_sort(int nums[], int n); //堆排序
void heapify(int nums[], int n, int i);
void radix_sort(int nums[], int n);//基数排序
void bucket_sort(int nums[], int n);//桶排序
void merge_sort(int nums[], int left, int right); //归并排序
void merge(int nums[], int left, int mid, int right);

int nums0[10000010], nums[10000010], n = 100; //数据量为

int main(){
	// 打开txt文件，没有文件自动创建
	std::ofstream out("C:/Users/30428/Desktop/算法分析与设计实验/算法分析与设计实验一/八大排序实验消耗时间.txt");

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, 10000); //数据范围为0 - 10000

    for (int i = 0; i < n; i++) {
        nums0[i] = dis(gen);
    }
    
    for (int i = 0; i < 8; i++) {
        for(int i = 0; i < n; i++) nums[i] = nums0[i];
        auto start = std::chrono::high_resolution_clock::now();

        switch (i)
        {
            case 0: select_sort(nums, n);  cout << "select_sort" << endl; break;
			case 1: insert_sort(nums, n);  cout << "insert_sort" << endl; break;
			case 2: bubble_sort(nums, n);  cout << "bubble_sort" << endl; break;
			case 3: quick_sort(nums, 0, n - 1);  cout << "quick_sort" << endl; break;
			case 4: heap_sort(nums, n);  cout << "heap_sort" << endl; break;
			case 5: radix_sort(nums, n);  cout << "radix_sort" << endl; break;
			case 6: bucket_sort(nums, n);  cout << "bucket_sort" << endl; break;
			case 7: merge_sort(nums, 0, n - 1);  cout << "merge_sort" << endl; break;
        }
        
        auto end = std::chrono::high_resolution_clock::now();
        //auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
        //以微妙为单位
		auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
        
        // 将排序消耗时间写入txt文件
        out << duration << std::endl;
        //std::cout << "Sorting time: " << duration << " milliseconds" << std::endl;
        std::cout << "Sorting time: " << duration << " microseconds" << std::endl;

    }
    
    
    return 0;
}
//选择排序
void select_sort(int nums[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            if (nums[i] > nums[j]) {
                swap(nums[i], nums[j]);
            }
        }
    }

    return;
}

//插入排序
void insert_sort(int nums[], int n) {
    // 从第二个元素开始遍历数组
    for (int i = 1; i < n; i++) {
        int tmp = nums[i]; // 暂存当前元素
        int j = i - 1; // 初始化比较索引
        // 比较当前元素与前一个元素
        while (nums[j] > tmp) {
            nums[j + 1] = nums[j]; // 向后移动元素
            j--;
        }
        nums[j + 1] = tmp; // 插入当前元素
    }
    return;
}

//冒泡排序
void bubble_sort(int nums[], int n) {
	for (int i = 0; i < n - 1; i++) {
		for (int j = 0; j < n - 1 - i; j++) {
			if (nums[j] > nums[j + 1]) {
				swap(nums[j], nums[j + 1]);
			}
		}
	}

	return;
}

//快速排序
void quick_sort(int nums[], int left, int right) {
    if (left >= right) return;

    int i = left, j = right, x = nums[left];
    while (i <= j) {
        while (nums[i] < x) i++;
        while (nums[j] > x) j--;
        if (i <= j) {
            swap(nums[i], nums[j]);
            i++;
            j--;
        }
    }

    if (left < j) quick_sort(nums, left, j);
    if (i < right) quick_sort(nums, i, right);
}

//堆排序

void buket_sort(int nums[], int n, int i) {
    int largest = i; // Initialize largest as root
    int left = 2 * i + 1; // left = 2*i + 1
    int right = 2 * i + 2; // right = 2*i + 2

    // If left child is larger than root
    if (left < n && nums[left] > nums[largest])
        largest = left;

    // If right child is larger than largest so far
    if (right < n && nums[right] > nums[largest])
        largest = right;

    // If largest is not root
    if (largest != i) {
        std::swap(nums[i], nums[largest]);

        // Recursively heapify the affected sub-tree
        heapify(nums, n, largest);
    }
}

void heap_sort(int nums[], int n) {
    // Build heap (rearrange array)
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(nums, n, i);

    // One by one extract an element from heap
    for (int i = n - 1; i > 0; i--) {
        // Move current root to end
        std::swap(nums[0], nums[i]);

        // Call max heapify on the reduced heap
        heapify(nums, i, 0);
    }
}
#include <algorithm> // for std::swap

void heapify(int nums[], int n, int i) {
    int largest = i; // Initialize largest as root
    int left = 2 * i + 1; // left = 2*i + 1
    int right = 2 * i + 2; // right = 2*i + 2

    // If left child is larger than root
    if (left < n && nums[left] > nums[largest])
        largest = left;

    // If right child is larger than largest so far
    if (right < n && nums[right] > nums[largest])
        largest = right;

    // If largest is not root
    if (largest != i) {
        std::swap(nums[i], nums[largest]);

        // Recursively heapify the affected sub-tree
        heapify(nums, n, largest);
    }
}


//基数排序
void radix_sort(int nums[], int n) {
    int max_digit = 0;
    for (int i = 0; i < n; i++) {
        int digit = 0;
        int num = nums[i];
        while (num > 0) {
            num /= 10;
            digit++;
        }
        max_digit = std::max(max_digit, digit);
    }

    for (int i = 0; i < max_digit; i++) {
        std::vector<int> buckets[10];
        for (int j = 0; j < n; j++) {
            int num = nums[j];
            int digit = (num / (int)pow(10, i)) % 10;
            buckets[digit].push_back(num);
        }
        int index = 0;
        for (int j = 0; j < 10; j++) {
            for (int k = 0; k < buckets[j].size(); k++) {
                nums[index++] = buckets[j][k];
            }
            buckets[j].clear();
        }
    }
}

//桶排序
void bucket_sort(int nums[], int n) {
    if (n <= 1) {
        return;
    }

    int max_value = nums[0];
    for (int i = 1; i < n; i++) {
        if (nums[i] > max_value) {
            max_value = nums[i];
        }
    }

    int bucket_count = max_value + 1;
    std::vector<std::vector<int>> buckets(bucket_count);

    for (int i = 0; i < n; i++) {
        int bucket_index = nums[i] * (bucket_count - 1) / max_value;
        buckets[bucket_index].push_back(nums[i]);
    }

    int index = 0;
    for (int i = 0; i < bucket_count; i++) {
        sort(buckets[i].begin(), buckets[i].end());
        for (int j = 0; j < buckets[i].size(); j++) {
            nums[index++] = buckets[i][j];
        }
    }
}

//归并排序
void merge_sort(int nums[], int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        merge_sort(nums, left, mid);
        merge_sort(nums, mid + 1, right);
        merge(nums, left, mid, right);
    }
}

void merge(int nums[], int left, int mid, int right) {
    int i = left;
    int j = mid + 1;
    int k = 0;
    std::vector<int> temp(right - left + 1);

    while (i <= mid && j <= right) {
        if (nums[i] <= nums[j]) {
            temp[k++] = nums[i++];
        }
        else {
            temp[k++] = nums[j++];
        }
    }

    while (i <= mid) {
        temp[k++] = nums[i++];
    }

    while (j <= right) {
        temp[k++] = nums[j++];
    }

    for (int l = 0; l < k; l++) {
        nums[left + l] = temp[l];
    }
}
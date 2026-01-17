# 从键盘接受若干个整数(直接输入回车表示输入结束),分别按照冒泡和选择法进行排序(按照由小到大的升序方式),并输出排序后的结果。


temp = input("请输入整数(直接回车结束):")
nums = []
while temp != "":
    temp = int(temp)
    nums.append(temp)
    temp = input("请输入整数(直接回车结束):")


def bubble_sort(nums):
    n = len(nums)
    for i in range(n):
        for j in range(0, n - i - 1):
            if(nums[j] > nums[j + 1]):
                nums[j], nums[j + 1] = nums[j + 1], nums[j]
    
    return nums

def selection_sort(nums):
    n = len(nums)
    for i in range(n):
        min_index = i
        for j in range(i + 1, n):
            if nums[j] < nums[min_index]:
                min_index = j
                nums[i], nums[min_index] = nums[min_index], nums[i]
    
    return nums

print("冒泡排序结果:", bubble_sort(nums.copy()))
print("选择排序结果:", selection_sort(nums.copy()))
print("冒泡排序和选择排序的时间复杂度均为O(n^2)")

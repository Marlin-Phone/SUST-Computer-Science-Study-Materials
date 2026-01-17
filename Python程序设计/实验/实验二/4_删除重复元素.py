# 实现删除一个列表中重复元素的功能
my_list = list(input("请输入列表").split(' '))
new_list = []
flag = 0
for i in my_list:
    if i not in new_list:
        new_list.append(i)
print("删除重复元素后的列表:", new_list)

'''
my_list = input("请输入一个列表：").split()
# new_list = list(set(my_list))
# print("删除重复元素后的列表：", new_list)


new_list = []
for i in my_list:
    for i in my_list:
        if i not in new_list:
            new_list.append(i)
print("删除重复元素后的列表：", new_list)
'''
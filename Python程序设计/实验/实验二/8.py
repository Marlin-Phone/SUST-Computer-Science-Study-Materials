# 创建由'Monday'~'Sunday'七个值组成的字典,输出键列表,值列表以及键值列表

days = {'Monday': 1, 'Tuesday': 2, 'Wednesday': 3, 'Thursday': 4, 'Friday': 5, 'Saturday': 6, 'Sunday': 7}
for key in days.keys():
    print(key, end = ' ')
print()
for value in days.values():
    print(value, end = ' ')
print()
for key, value in days.items():
    print(key, value, end = ' ')
print()
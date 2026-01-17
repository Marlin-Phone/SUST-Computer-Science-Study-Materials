# 2.编写程序，输人直角三角形的两条直角边，利用勾股定理计算斜边的长度(结果保留
# 两位小数)并输出。

import math

a = float(input("请输入第一个边长:"))
b = float(input("请输入第二个边长:"))

c = math.sqrt(a**2 + b**2)

print("斜边的长度为{:.2f}".format(c))


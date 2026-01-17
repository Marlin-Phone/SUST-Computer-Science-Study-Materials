# 输入三角形三个边,先判断是否可以构成三角形,如果可以,则求
# 三角形的周长和面积,否则报错"无法构成三角形!"
import math

a = float(input("请输入第一个边长:"))
b = float(input("请输入第二个边长:"))
c = float(input("请输入第三个边长:"))
if a + b > c and a + c > b and b + c > a and a > 0 and b > 0 and c > 0:
    perimeter = a + b + c
    h = perimeter / 2
    area = math.sqrt(h * (h - a) * (h - b) * (h - c))
    print(f"周长:{perimeter:.2f}\n面积:{area:.2f}")
else:
    print("无法构成三角形!")
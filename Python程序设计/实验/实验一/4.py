import math

# 输入球的半径, 计算球的表面积和体积(结果保留2位小数)
r = float(input("请输入球的半径:"))
# 计算球的表面积
surface_area = 4 * math.pi * r ** 2
# 计算球的体积
volume = (4/3) * math.pi * r ** 3
# 输出结果
print("球的表面积为:" + f"{surface_area:.2f}")
print("球的体积为:" + f"{volume:.2f}")
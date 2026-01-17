# 创建一个求圆的面积和体积的模块AreaVolume.py,并编写只有独立运行时才执行的测试代码
# 要求输入半径,输出结果保留两位小数
import math
def getArea(r):
    return 1/2 * math.pi * r * r
def getVolume(r):
    return 4/3 * math.pi * r ** 3

if __name__ == '__main__':
    r = float(input("请输入半径r:"))
    print(f"圆的面积为:{getArea(r):.2f}")
    print(f"球的体积为:{getVolume(r):.2f}")

"""import math
def area(r):
    area = math.pi * r ** 2
    return area

def volume(r):
    volume = (4/3) * math.pi * r ** 3
    return volume

if __name__ == '__main__':
    r = float(input("请输入半径:"))
    print(f"圆的面积: {area(r):.2f}")
    print(f"球的体积: {volume(r):.2f}")
"""
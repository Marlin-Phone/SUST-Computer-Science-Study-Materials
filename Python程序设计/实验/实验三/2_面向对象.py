# 创建类MyMath,计算圆的周长和面积以及球的表面积和体积,并编写测试代码,结果保留两位数
import math
class MyMath:
    def __init__(self, r = 1):
        self.r = r
        self.circle_C = math.pi * 2 * r
        self.circle_S = math.pi * 1/2 * r * r
        self.ball_S = 4 * math.pi * r ** 3
        self.ball_V = 4/3 * math.pi * r ** 3

if __name__ == '__main__':
    r = input("请输入半径r:")
    test1 = MyMath(float(r))
    print(f"圆的周长:{test1.circle_C:.2f}")
    print(f"圆的面积:{test1.circle_S:.2f}")
    print(f"球的表面积:{test1.circle_C:.2f}")
    print(f"球的体积:{test1.circle_S:.2f}")

"""import math

class MyMath:
    def __init__(self, r = 1):
        self.r = r
        self.cycleA = math.pi * r ** 2
        self.cycleC = math.pi * 2 * r
        self.ballSurfaceA = 4 * math.pi * r ** 2
        self.ballVolume = (4/3) * math.pi * r ** 3
    
# 测试代码
if __name__ == '__main__':
    r = input("请输入半径:")
    test1 = MyMath(float(r))
    print(f"圆的周长为:{test1.cycleC:.2f}")
    print(f"圆的面积为:{test1.cycleA:.2f}")
    print(f"球的表面积为:{test1.ballSurfaceA:.2f}")
    print(f"球的体积为:{test1.ballVolume:.2f}")"""
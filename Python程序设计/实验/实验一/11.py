import math
x = float(input("输入x:"))
if x >= 0:
    ans = (x**2 - 3*x) / (x + 1) + 2*math.pi + math.sin(x)
else:
    ans = math.log(-5*x) + 6*math.sqrt(abs(x)+math.e**4) - (x + 1)**3

print("结果为:", ans)
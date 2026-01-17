#
import random
import math

a = random.randint(1, 100)
b = random.randint(1, 100)

print(f"整数1 = {a}, 整数2 = {b}")
print(f"最大公约数 = {math.gcd(a, b)}")
print(f"最小公倍数 = {math.lcm(a, b)}")
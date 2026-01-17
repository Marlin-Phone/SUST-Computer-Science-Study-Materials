# 随机生成10个0(含)~10(含)的整数,分别组成集合A和集合B的
# 内容,长度,最大值,最小值以及它们的并集,交集和差集
import random

A = set()
B = set()

for i in range(10):
    s = random.randint(0, 10)
    A.add(random.randint(0, 10))
    B.add(random.randint(0, 10))

print("集合A:", A)
print("集合B:", B)

print("集合A的最大值:", max(A))
print("集合A的最小值:", min(A))

print("集合B的最大值:", max(B))
print("集合B的最小值:", min(B))

print("集合A和集合B的并集:", A.union(B))
print("集合A和集合B的交集:", A.intersection(B))
print("集合A和集合B的差集:", A.difference(B))

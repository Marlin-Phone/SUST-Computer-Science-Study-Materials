# 将列表s = [9,7,8,3,2,1,5,6]中的偶数变成它的平方,奇数保持不变
s = [9,7,8,3,2,1,5,6]
print("变换前:", s)
for i in range(len(s)):
    if s[i] % 2 == 0:
        s[i] *= s[i]
print("变换后:", s)

"""
s = [9,7,8,3,2,1,5,6]
print("变换前:",s)
for i in range(len(s)):
    if s[i] % 2 == 0:
        s[i] = s[i] ** 2
    else:
        continue

print("变换后:",s)"""
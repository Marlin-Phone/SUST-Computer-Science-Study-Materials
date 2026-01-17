# 统计字符串中英文字母,数字,空格和其他字符的个数

s = input("请输入字符串:")
zimu_count = 0
shuzi_count = 0
kongge_count = 0
qita_count = 0
for i in s:
    if (i >= 'a' and i <= 'z') or (i >= 'A' and  i <= 'Z'):
        zimu_count += 1
    elif i >= '0' and i <= '9':
        shuzi_count += 1
    elif i == ' ':
        kongge_count += 1
    else:
        qita_count += 1

print("字母个数:", zimu_count)
print("数字个数:", shuzi_count)
print("空格个数:", kongge_count)
print("其它字符个数:", qita_count)

'''
string = input("请输入字符串：")

letter_count = 0
digit_count = 0
space_count = 0
other_count = 0

for char in string:
    if char >= 'a' and char <= 'z' or char >= 'A' and char <= 'Z':
        letter_count += 1
    elif char >= '0' and char <= '9':
        digit_count += 1
    elif char == ' ':
        space_count += 1
    else:
        other_count += 1

print("字母个数：", letter_count)
print("数字个数：", digit_count)
print("空格个数：", space_count)
print("其他字符个数：", other_count)

'''
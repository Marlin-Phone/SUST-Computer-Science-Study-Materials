# 输入字符串,为其每个字符的ASCII码形成列表并输出
# 1.使用ord(s[i])将字符转换为对应的Unicode码
# 2.利用s.append(x)方法将对象x追加到列表s尾部

s = input("请输入字符串:")
s_list = list(s)
for i in range(len(s_list)):
    s_list[i] = ord(s_list[i])
print(s_list)

"""s = input("请输入字符串：")
list = []
for i in range(len(s)):
    list.append(ord(s[i]))
print(list)"""
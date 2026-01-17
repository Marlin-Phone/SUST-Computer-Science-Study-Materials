# 编写程序生成随机密码
# 1.使用random库,采用0x1010作为随机数种子
# 2.密码由26个字母大小写,10个数字字符以及"!,@,#,$,%,^,&,*"等8个特殊符号组成
# 3.密码长度固定为10个字符
# 4.程序运行时每次产生10个密码,每个密码占一行
# 5.每次产生的10个密码首字符不能一样
# 6.程序运行后产生的密码保存在"随机密码.txt"文件中

import random

# 定义密码字符集
chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*"

# 定义密码长度
length = 10

# 定义密码文件名
filename = "随机密码.txt"

# 定义密码列表
passwords = []

# 定义首字符列表
first_chars = []

# 定义随机数种子
random.seed(0x1010)

# 循环产生密码
while len(passwords) < 10:
    # 产生密码
    password = ""
    for i in range(length):
        # 产生随机字符
        char = random.choice(chars)
        # 密码首字符不能一样
        if i == 0:
            while char in first_chars:
                char = random.choice(chars)
        # 添加字符到密码
        password += char
    # 添加密码到列表
    passwords.append(password)
    # 添加首字符到列表
    first_chars.append(password[0])

# 写入密码文件
with open(filename, "w") as f:
    for password in passwords:
        f.write(password + "\n")
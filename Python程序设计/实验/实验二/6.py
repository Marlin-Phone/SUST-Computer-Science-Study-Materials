# 从键盘输入一些字符,逐个把它们写到指定的文件中,直到输入一个@字符为止
import sys
filename = sys.argv[1]
with open(filename, "w", encoding = "utf-8") as f:
    while True:
        char = input()
        if char == '@':
            break
        f.write(char)    

"""import sys

filename = sys.argv[1]

with open(filename, 'w', encoding = "utf-8") as f:
    while True:
        char = input()
        if char == '@':
            break
        f.write(char)
"""
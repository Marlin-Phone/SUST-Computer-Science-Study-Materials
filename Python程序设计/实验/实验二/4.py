# 修改例6.9编写利用with语句读取并输出文件文本的程序,由命令行第一个参数确认所输出的文本文件名
import sys
filename = sys.argv[1]
line_num = 0
with open(filename, "r", encoding = "utf-8") as f:
    for line in f:
        line_num += 1    
        print(line_num,":",line,end='')

"""import sys

filename = sys.argv[1]
line_no = 0
with open(filename, 'r', encoding = "utf-8") as f:
    for line in f:
        line_no += 1
        print(line_no,":",line, end = '')
"""
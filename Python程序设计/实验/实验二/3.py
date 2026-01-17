# 修改例6.8编写读取并输出文本文件的程序,由命令行第一个参数确认所需输出的文本文件名

import sys
filename = sys.argv[1]

with open(filename, 'r', encoding = "utf-8") as f:
    line_no = 0
    while True:
        line_no += 1
        line = f.readline()
        if line:
            print(line_no, ":", line, end='')
        else:
            break
# 打印九九乘法表,要求输出九九乘法表的各种显示效果

# 1. 打印九九乘法表
for i in range(1, 10):
    for j in range(1, i + 1):
        print(f"{j}×{i}={i*j}", end="\t")  # 使用制表符对齐
    print()  # 换行

print()

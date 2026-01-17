# 利用元组作为函数的返回值,求序列类型中的最大值,最小值和元素个数,并编写测试代码
# 假设测试数据分别为s1 = [9, 7, 8, 3, 2, 1, 55, 6], s2 = ["apple", "pear", "melon", "kiwi"] 和 s3 = "TheQuickBrownFox"

def max_min_count(seq):
    n = len(seq)
    max_val = max(seq)
    min_val = min(seq)

    return (max_val, min_val, n)

# 测试代码
if __name__ == '__main__':
    s1 = [9, 7, 8, 3, 2, 1, 55, 6]
    s2 = ["apple", "pear", "melon", "kiwi"]
    s3 = "TheQuickBrownFox"
    print(max_min_count(s1))
    print(max_min_count(s2))
    print(max_min_count(s3))
    
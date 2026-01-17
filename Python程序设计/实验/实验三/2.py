# 定义一个求阶乘的函数fact(n),并编写测试代码,要求输出整数n(n >= 0)
# 分别用递归和非递归实现

def fact_no_digui(n):
    ans = 1
    for i in range(1, n + 1):
        ans *= i
    return ans


def fact_digui(n):
    if n == 0:
        return 1
    else:
        return n * fact_digui(n-1)
    

if __name__ == '__main__':
    n = int(input("请输入一个整数:"))
    print("递归求阶乘:", fact_digui(n))
    print("非递归求阶乘:", fact_no_digui(n))
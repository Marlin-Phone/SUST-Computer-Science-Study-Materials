# 编写程序,判断一个字符串是否为回文字符串.
# 要求使用至少
# "字符串逆序切片方法[::-1]"
# "for循环遍历并逐字符比较"
# "将字符串转换为list后再利用reversed()函数将字符串反序"
# 以及"递归"等5种方法实现回文字符串的判断.

# 字符串逆序切片方法[::-1]
def is_palindrome_slice(s):
    return s == s[::-1]

# for循环遍历并逐字符比较
def is_palindrome_for(s):
    for i in range(len(s)):
        if s[i] != s[len(s) - 1 - i]:
            return False
    return True

# 将字符串转换为list后再利用reversed()函数将字符串反序
def is_palindrome_reversed(s):
    return list(s) == list(reversed(s))

# 递归
def is_palindrome_recursive(s, start, end):
    if start >= end:
        return True
    if s[start]!= s[end]:
        return False
    return is_palindrome_recursive(s, start + 1, end - 1)

if __name__ == '__main__':
    s = input("请输入字符串:")
    print("字符串逆序切片方法[::-1]:", is_palindrome_slice(s))
    print("for循环遍历并逐字符比较:", is_palindrome_for(s))
    print("将字符串转换为list后再利用reversed()函数将字符串反序:", is_palindrome_reversed(s))
    print("递归:", is_palindrome_recursive(s, 0, len(s) - 1))

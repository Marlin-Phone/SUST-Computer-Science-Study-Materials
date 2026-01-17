# 统计输入的字符串中单词的个数,单词之间用空格分隔
words = input("请输入字符串: ")
word_list = list(words.split())
word_count = len(word_list)
print("字符串中单词个数为:", word_count)

'''
words = input("请输入字符串: ")
word_list = words.split()
word_count = len(word_list)
print("单词的个数为:", word_count)

'''
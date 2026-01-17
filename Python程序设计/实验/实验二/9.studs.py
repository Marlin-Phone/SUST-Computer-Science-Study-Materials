# 假设有一个存放学生学号和语数英三门功课的列表studs如下:
studs = [{'sid':'103','chinese':90,'math':95,'English':82},
         {'sid':'104','chinese':80,'math':85,'English':82},
         {'sid':'102','chinese':70,'math':88,'English':72}]
# 编写程序,将列表studs的数据内容提取出来,
# 放到一个字典scores中,
# 在屏幕上按照学号从小到大的顺序显示输出所有学生的学号
# 及语数英三门功课的成绩

scores = {}
for i in range(len(studs)):
    scores

# 方法1：直接字典推导式（最简洁）
scores = {item['sid']: {
    'chinese': item['chinese'],
    'math': item['math'],
    'English': item['English']  # 注意原数据键名大小写需统一
} for item in studs}

# 按学号排序输出(两种方式任选)
print("学号\t语文\t数学\t英语")
for sid in sorted(scores.keys()):
    print(f"{sid}\t{scores[sid]['chinese']}\t{scores[sid]['math']}\t{scores[sid]['English']}")
    
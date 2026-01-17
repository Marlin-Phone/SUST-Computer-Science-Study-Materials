# 假设当前目录下有一个文件名为scorel.txt的文本文件,存放着某班学生的计算机课程成绩
# 共有学生学号,平时成绩和期末成绩三列,每一行数据之间采用空格分隔.
# 1.根据平时成绩40%,期末成绩60%的比例计算总评成绩(取整数),并将每个学生的学号和总评成绩输出到另一个文件score2.txt中,每个学生的数据占据一行
# 2.在屏幕上输出本班学生总人数
# 3.根据总评成绩,统计并输出90以上,80-89,70-79,60-89,60分以下各成绩档学生的人数,并输出班级总平均分(保留一位小数)

with open("score1.txt", "r", encoding="utf-8") as f:
    students = []
    for line in f:
        items = line.strip().split()
        if len(items) != 3:  # 确保每行有三列数据
            continue
        student_id, usual_score, final_score = items 
        usual_score = int(usual_score)
        final_score = int(final_score)
        total_score = int(usual_score * 0.4 + final_score * 0.6)
        students.append((student_id, total_score))

# 1. 将学号和总评成绩写入score2.txt
with open("score2.txt", "w", encoding="utf-8") as f:
    for student in students:
        f.write(f"{student[0]} {student[1]}\n")

# 2. 输出学生总人数
print(f"本班学生总人数: {len(students)}")

# 3. 统计各分数段人数和平均分
score_ranges = {
    "90以上": 0,
    "80-89": 0,
    "70-79": 0,
    "60-69": 0,  # 修正了题目中的错误(60-89应为60-69)
    "60分以下": 0
}

total = 0
for student in students:
    score = student[1]
    total += score
    if score >= 90:
        score_ranges["90以上"] += 1
    elif 80 <= score <= 89:
        score_ranges["80-89"] += 1
    elif 70 <= score <= 79:
        score_ranges["70-79"] += 1
    elif 60 <= score <= 69:
        score_ranges["60-69"] += 1
    else:
        score_ranges["60分以下"] += 1

# 输出各分数段人数
print("各分数段人数:")
for range_name, count in score_ranges.items():
    print(f"{range_name}: {count}人")

# 输出平均分(保留一位小数)
average = total / len(students) if students else 0
print(f"班级总平均分: {average:.1f}")

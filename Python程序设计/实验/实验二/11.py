# class_score.txt的文本文件,存放着某班学生学号(第一列),语文成绩(第二列)和数学成绩(第三列)
# 1.分别求出这个班语文成绩和数学成绩的平均分(保留一位小数)并输出
# 2.找出这两个班两门课都不及格(<60)的学生,输出这些学生的学号,语文成绩和数学成绩
# 3.找出这个班两门课的平均成绩为优秀(>=90)的学生,输出这些学生的学号,语文成绩,数学成绩和平均成绩

# with open("class_score.txt", "w", encoding = "utf-8") as f:
#     f.write("1 100 80\n")
#     f.write("2 90 70\n")
#     f.write("3 80 60\n")
#     f.write("4 70 50\n")
#     f.write("5 60 40\n")
#     f.write("6 50 30\n")

# 学生成绩统计程序
# 功能：读取学生成绩文件，计算平均分，找出不及格和优秀的学生

# 1. 首先打开成绩文件（使用utf-8编码防止中文乱码）
with open("class_score.txt", "r", encoding="utf-8") as f:
    # 读取所有行，每行是一个学生的成绩信息
    lines = f.readlines()
    
    # 初始化统计用的变量
    chinese_total = 0  # 语文总分
    math_total = 0     # 数学总分
    student_count = 0  # 学生人数
    fail_students = [] # 两门不及格的学生列表
    excellent_students = [] # 优秀学生列表
    
    print("正在读取学生成绩...")
    
    # 2. 处理每一行数据
    for line in lines:
        # 去掉行首尾的空白字符（如换行符）
        line = line.strip()
        
        # 跳过空行（如果有的话）
        if not line:
            continue
            
        # 3. 拆分每行数据：学号 语文成绩 数学成绩
        student_id, chinese_str, math_str = line.split()
        
        # 将成绩字符串转换为整数
        chinese = int(chinese_str)
        math = int(math_str)
        
        # 4. 统计总分（用于计算平均分）
        chinese_total += chinese
        math_total += math
        student_count += 1
        
        # 5. 检查是否两门都不及格（<60分）
        if chinese < 60 and math < 60:
            fail_students.append((student_id, chinese, math))
            
        # 6. 检查是否平均分优秀（>=90分）
        average = (chinese + math) / 2
        if average >= 90:
            excellent_students.append((student_id, chinese, math, average))

# 7. 计算并输出平均分（保留1位小数）
if student_count > 0:
    print("\n=== 班级成绩统计 ===")
    print(f"语文平均分: {chinese_total/student_count:.1f}")
    print(f"数学平均分: {math_total/student_count:.1f}")
else:
    print("警告：没有读取到任何学生成绩！")

# 8. 输出两门不及格的学生
if fail_students:
    print("\n=== 两门不及格的学生 ===")
    for student in fail_students:
        print(f"学号: {student[0]}, 语文: {student[1]}, 数学: {student[2]}")
else:
    print("\n没有两门都不及格的学生")

# 9. 输出优秀学生
if excellent_students:
    print("\n=== 平均分优秀的学生(>=90分) ===")
    for student in excellent_students:
        print(f"学号: {student[0]}, 语文: {student[1]}, 数学: {student[2]}, 平均分: {student[3]:.1f}")
else:
    print("\n没有平均分优秀的学生")

print("\n统计完成！")

# 提取data.txt中的json数据,将文件中的数据内容提取出来,计算每个人的平均工资,将其转化为字典salary,按照key的
# 升序排列,并输出到终端中

# with open("data.txt", "w", encoding = "utf-8") as f:
#     f.write("{'sid':'501','7月':9000,'8月':9500,'9月':9200}\n")
#     f.write("{'sid':'502','7月':8000,'8月':8500,'9月':8200}\n")
#     f.write("{'sid':'503','7月':7000,'8月':7500,'9月':7200}\n")

with open("data.txt", "r", encoding = "utf-8") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue

        try:
            data = eval(line)
        except (SyntaxError, TypeError):
            print(f"格式错误:{line}")
            continue
    
    sid = data.get('sid', '未知')
    salaries = [
        data.get('7月', 0),
        data.get('8月', 0),
        data.get('9月', 0)
    ]

    avg_salary = sum(salaries) / len(salaries)
    avg_salary = round(avg_salary, 2)

    
    print(f"{sid}:{{{salaries[0]}, {salaries[1]}, {salaries[2]}, 平均工资:{avg_salary}}}")
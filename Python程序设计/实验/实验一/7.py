import datetime
# 提示输入姓名和出生年份,输出姓名和年龄.
name = input("请输入您的姓名:")
birth = int(input("请输入您的出生年份:"))
age = str(datetime.date.today().year - birth)
print("您的姓名为" + name + ",年龄为" + age + "岁")

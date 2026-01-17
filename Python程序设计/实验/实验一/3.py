#输入本金,年利率和年份,计算复利
#输入本金
principal = float(input("请输入本金："))
#输入年利率
rate = float(input("请输入年利率："))
#输入年份
years = int(input("请输入年份："))
#计算复利
amount = principal * (1 + rate/100) ** years
#输出结果
print("本息合计：%.2f" % amount)
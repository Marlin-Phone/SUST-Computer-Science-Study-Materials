# 18自幂数探索。输人一个1~10的整数，编写程序输出相应的自幂数名称、数量和具
# 体的数值，程序运行效果如图3-34(a）所示。读者可进一步编程，输出1~10所有自幂数的
# 名称、数量和具体的数值清单，程序运行效果如图3-34(b）所示。
# 腔身数9个:123456789
# 商位数设有门系取！
# 深祥花
# M输入自移政位效心三非1e10：
# 工拍屋数3个：54748 92727 93084
# 北牛七星数4个：
# 订合个：548834
# 5
# 42108253
# 九九面用数4个：14511208 472335975 5391830 9129153
# 9800817
# 件全干员数1个：4679307774
# 9926315
# (6)1～10所有自幂数的清单
# (@)输出指定的自幂数

def find_armstrong_numbers(n):
    """查找指定位数的自幂数"""
    start = 10**(n-1) if n > 1 else 0
    end = 10**n
    armstrong_numbers = []
    
    for num in range(start, end):
        total = 0
        temp = num
        while temp > 0:
            digit = temp % 10
            total += digit ** n
            temp //= 10
        if total == num and num != 0:
            armstrong_numbers.append(num)
    return armstrong_numbers

def get_armstrong_name(n):
    """获取自幂数的中文名称"""
    names = {
        1: "独身数",
        2: "没有自幂数",
        3: "水仙花数",
        4: "四叶玫瑰数",
        5: "五角星数",
        6: "六合数",
        7: "北斗七星数",
        8: "八仙花数",
        9: "九九重阳数",
        10: "十全十美数"
    }
    return names.get(n, "未知自幂数")

def main():
    import sys
    
    print("自幂数计算器")
    print("1. 查询指定位数自幂数")
    print("2. 显示所有自幂数清单")
    
    choice = input("请选择模式(1/2): ")
    
    if choice == '1':
        try:
            n = int(input("请输入位数(1-10): "))
            if not 1 <= n <= 10:
                raise ValueError
        except:
            print("输入无效，请输入1-10之间的整数")
            sys.exit()
            
        numbers = find_armstrong_numbers(n)
        name = get_armstrong_name(n)
        count = len(numbers)
        
        if count == 0:
            print(f"{name}：不存在")
        else:
            print(f"{name}{count}个：", end="")
            print(" ".join(map(str, numbers)))
            
    elif choice == '2':
        print("\n1~10位自幂数清单：")
        for n in range(1, 11):
            numbers = find_armstrong_numbers(n)
            name = get_armstrong_name(n)
            if numbers:
                print(f"{name}({n}位): {len(numbers)}个")
                print("  ", "  ".join(map(str, numbers)))
            else:
                print(f"{name}({n}位): 无")
                
    else:
        print("无效选择")

if __name__ == "__main__":
    main()

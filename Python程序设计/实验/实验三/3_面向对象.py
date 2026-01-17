# 创建类Temperature,包含成员变量degree(温度)以及实例方法ToFahrenheit()(将摄氏温度转换为华氏温度)和ToCelsius()(将华氏温度转换为设施温度)并编写测试代码
class Temperature:
    def __init__(self, degree=0):
        """构造方法：初始化实例属性"""
        self.degree = degree  # 这才是实例属性
    
    def to_fahrenheit(self):
        """实例方法：摄氏→华氏转换"""
        return (self.degree * 9/5) + 32  # 使用9/5比1.8更精确
    
    def to_celsius(self):
        """实例方法：华氏→摄氏转换"""
        return (self.degree - 32) * 5/9

if __name__ == '__main__':
    # 测试代码
    temp1 = Temperature(100)  # 创建实例
    print(f"100°C = {temp1.to_fahrenheit()}°F")  # 输出: 212.0°F
    
    temp2 = Temperature(212)
    print(f"212°F = {temp2.to_celsius()}°C")  # 输出: 100.0°C

    temp3 = Temperature()
    print(f"0°C = {temp3.to_fahrenheit()}°F")  # 输出: 32.0°F

# 编写程序, 利用循环结构,使用turtle库的turtle.circle()函数
# turtle.seth()函数和turtle.left()函数绘制一个四瓣花图形,从左上角花瓣开始
import turtle

# 初始化设置
pen = turtle.Turtle()
pen.pendown()
for i in range(4):
    pen.circle(100, 180)  # 绘制半圆花瓣
    pen.left(90)          # 每次旋转90度（360/4）
pen.hideturtle()
turtle.done()

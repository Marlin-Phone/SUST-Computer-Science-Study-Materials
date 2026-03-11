/*
实验二 类与对象定义初始化-第一部分
内容提要
1. 一圆型游泳池如图所示，现在需在其周围建一圆型过道，并在其四周围上栅栏。栅栏价格为35元/米，过道造价为20元/平方米。过道宽度为3米，游泳池半径由键盘输入。要求编程计算并输出过道和栅栏的造价。
2. 有三个学生组队参加某比赛，每个学生信息包含准考证号，姓名，个人成绩，另团队有一总成绩。
请写一学生类完成其定义实现。注意其中准考证号的不可变性，团队成绩的共享性；
编写主程序模拟生成三个学生给其赋值、完成相关信息的输出。
基本要求
能定义适当的类并定义对象完成设计并提交程序清单。
*/
#include <iostream>
#define Pi 3.14
using namespace std;
class Circle{
private:
	double r, c, s;
public:
	void getR(double r) {
		this->r = r;
	}
	double getC() {
		c = 2 * Pi * r;
		return c;
	}
	double getS() {
		s = (1.0 / 2) * Pi * r * r;
		return s;
	}
};

int main() { 
	double r1, r2, priceC, priceS;
	Circle c1, c2;
	cout << "请输入游泳池的半径r：";
	cin >> r1;
	r2 = r1 + 3;

	c1.getR(r1);
	c2.getR(r2);
	priceC = (c1.getC() + c2.getC()) * 35;
	priceS = (c2.getS() - c1.getS()) * 20;
	cout << "过道造价为：" << priceS << endl;
	cout << "栏杆造价为：" << priceC << endl;
	return 0;
}
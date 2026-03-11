/*
第一部分：运算符重载
1.对于类MyString,要求重载‘+’运算符后可以计算表达式:a=b+c;表示两个字符串连接。其中a,b,c都是类MyString的对象。
2.使用虚函数编写程序求球体和圆柱体的体积及表面积。由于球体和圆柱体都可以看作由圆继承而来，所以可以定义圆类Circle作为基类。在Circle类中定义一个数据成员radius和两个虚函数area()和volume()。由Circle类派生Sphere类和Column类。在派生类中对虚函数area()和volume()重新定义，分别求球体和圆柱体的体积及表面积。
基本要求
重载相应的运算符并编写程序，能运用虚函数编写程序测试并提交程序。
*/
#include <iostream>
using namespace std;

class MyString {
private:
	string str;
public:
	MyString() {}
	MyString(string str) { this->str = str; }
	friend MyString operator +(MyString& Mstr1, MyString& Mstr2) {
		return MyString(Mstr1.str + Mstr2.str);
	}
	friend ostream& operator << (ostream& output, MyString& Mstr) {
		output << Mstr.str;
		return output;
	}
	friend istream& operator >> (istream& input, MyString& Mstr) {
		input >> Mstr.str;
		return input;
	}
};
int main() {
	MyString Mstr1, Mstr2, Mstr3;
	cin >> Mstr1 >> Mstr2;
	Mstr3 = Mstr1 + Mstr2;
	cout << Mstr3 << endl;
	return 0;
}
/*
实验三 继承性和派生类
内容提要
建立一个楼房基类Building为基类，用于存储地址和楼号，建立住宅类House继承Building，用来存储房号和面积，
另外建立办公室类Office继承Building，存储办公室名称和电话号码。
基本要求
编制应用程序，建立住宅和办公室对象测试之并输出有关数据提交程序。
*/
/*
输入数据：
陕西科技大学学生生活区 6 222 16.4
陕西科技大学 2A 辅导员办公室 15398090480
*/
#include <iostream>
#include <string>
using namespace std;

class Buliding {
private:
	string address;
	string buliding_num;
public:
	void getBInformation() {
		cin >> address >> buliding_num;
	}
	void printBInformation() {
		cout << "地址为：" << address << endl << "楼号为：" << buliding_num << endl;
	}
};
class House :public Buliding { //House子类 父类为Buliding 
private:
	int room_num;
	double area;
public:
	void getHInformation() {
		getBInformation();
		cin >> room_num >> area;
	}
	void printHInformation() {
		cout << "（住宅）" << endl;
		printBInformation();
		cout << "房号为：" << room_num << endl << "面积为：" << area << endl;
	}
};
class Office :public Buliding { //Office子类 父类为Buliding
private:
	string office_name;
	string phone_num;
public:
	void getOInformation() {
		getBInformation();
		cin >> office_name >> phone_num;
	}
	void printOInformation() {
		cout << "（办公室）" << endl;
		printBInformation();
		cout << "办公室名称为：" << office_name << endl << "电话为：" << phone_num << endl;
	}
};
int main() {
	House h;
	Office o;
	cout << "请输入住宅地址、楼号、房号、面积" << endl;
	h.getHInformation();
	cout << "请输入办公室地址、楼号、名称、电话号码" << endl;
	o.getOInformation();
	
	cout << endl;
	
	h.printHInformation();
	o.printOInformation();
	
	return 0;
}
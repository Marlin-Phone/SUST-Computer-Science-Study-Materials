/*
第二部分：虚函数
1.对于类MyString,要求重载‘+’运算符后可以计算表达式:a=b+c;表示两个字符串连接。其中a,b,c都是类MyString的对象。
2.使用虚函数编写程序求球体和圆柱体的体积及表面积。由于Ball和Cylinder都可以看作由圆继承而来，所以可以定义圆类Circle作为基类。在Circle类中定义一个数据成员radius和两个虚函数area()和volume()。由Circle类派生Sphere类和Column类。在派生类中对虚函数area()和volume()重新定义，分别求球体和圆柱体的体积及表面积。
基本要求
重载相应的运算符并编写程序，能运用虚函数编写程序测试并提交程序。
*/
#include <iostream>
#define M_PI 3.1416
using namespace std;

// 基类 Circle
class Circle {
protected:
    double radius;

public:
    Circle(double r) : radius(r) {}

    // 虚函数 area()，计算面积
    virtual double area() const {
        return M_PI * radius * radius;
    }

    // 虚函数 volume()，计算体积
    virtual double volume() const {
        return 0; // 圆的体积为 0，因为圆是二维图形
    }

    // 虚析构函数
    virtual ~Circle() {}
};

// 派生类 Sphere，球体
class Sphere : public Circle {
public:
    Sphere(double r) : Circle(r) {}

    // 重写 area() 函数，计算球体表面积
    double area() const override {
        return 4 * M_PI * radius * radius;
    }

    // 重写 volume() 函数，计算球体体积
    double volume() const override {
        return (4.0 / 3.0) * M_PI * pow(radius, 3);
    }
};

// 派生类 Cylinder，圆柱体
class Cylinder : public Circle {
private:
    double height;

public:
    Cylinder(double r, double h) : Circle(r), height(h) {}

    // 重写 area() 函数，计算圆柱体表面积
    double area() const override {
        return 2 * M_PI * radius * (radius + height);
    }

    // 重写 volume() 函数，计算圆柱体体积
    double volume() const override {
        return M_PI * radius * radius * height;
    }
};

int main() {
    Sphere sphere(5.0);
    Cylinder cylinder(3.0, 7.0);

    cout << "Sphere area: " << sphere.area() << endl;
    cout << "Sphere volume: " << sphere.volume() << endl;

    cout << "Cylinder area: " << cylinder.area() << endl;
    cout << "Cylinder volume: " << cylinder.volume() << endl;

    return 0;
}

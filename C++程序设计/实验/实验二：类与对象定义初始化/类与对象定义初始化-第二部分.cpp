/*
实验二 类与对象定义初始化-第二部分
内容提要
1. 一圆型游泳池如图所示，现在需在其周围建一圆型过道，并在其四周围上栅栏。栅栏价格为35元/米，过道造价为20元/平方米。过道宽度为3米，游泳池半径由键盘输入。要求编程计算并输出过道和栅栏的造价。
2. 有三个学生组队参加某比赛，每个学生信息包含准考证号，姓名，个人成绩，另团队有一总成绩。
请写一学生类完成其定义实现。注意其中准考证号的不可变性，团队成绩的共享性；
编写主程序模拟生成三个学生给其赋值、完成相关信息的输出。
基本要求
能定义适当的类并定义对象完成设计并提交程序清单。
*/
/*
输入数据：
202307020122 马凌峰 100
202407010521 王二麻 90
202207070211 李三三 80
*/
#include <iostream>
#include <string>
using namespace std;

class Student {
private:
    string idnumber; // 准考证号，不可变（本次实验中未体现）
    string name;
    double score;
    static double teamscore; // 团队成绩，共享

public:
    void setInformation() { // 设置学生信息并累加团队总分
        cin >> this->idnumber >> this->name >> this->score;
        teamscore += score;
    }
    // 打印学生信息
    void printInformation()  {
        cout << "准考证号为：" << idnumber << endl;
        cout << "姓名为：" << name << endl;
        cout << "分数为：" << score << endl;
    }

    // 获取团队成绩
    static double getTeamScore() {
        return teamscore;
    }
};

// 初始化静态成员变量
double Student::teamscore = 0;

int main() {
    Student stu[3];
    string idnumber, name;
    double score = 0.0;
    for (int i = 0; i < 3; i++) {
        cout << "请分别输入第" << i + 1 << "位同学的准考证号、姓名、分数：" << endl;
        stu[i].setInformation();
    }
    for (int i = 0; i < 3; i++) {
        stu[i].printInformation();
    }
    cout << "团队总分为：" << Student::getTeamScore() << endl;
    return 0;
}

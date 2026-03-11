/*
实验五 文件操作
内容提要
1.创建一个文件输出流对象，通过构造函数指定磁盘文件名。
2.通过文件输出流对象，写入若干行文字。
3.关闭文件输出流对象，然后观察磁盘文件内容。
4.改用open函数创建文件输出流，并选择适当的文件操作方式。
5.在原内容的后面追加若干行新内容。
基本要求
能熟练运用文件各种操作编写程序测试并提交程序。
*/
#include <iostream>
#include <fstream> // 包含文件流类的头文件
using namespace std;

class FileHandler {
private:
    string filename; // 文件名
public:
    FileHandler(const string& filename) : filename(filename) {}

    void writeToFile() {
        ofstream file(filename);
        file << "Hello, world!\n";
        file.close();
    }

    void appendToFile() {
        ofstream file(filename, ios::app);
        file << "This is another line." << endl;
        file.close();     
    }
};

int main() {
    FileHandler fileHandler("example.txt");

    // 写入初始内容
    fileHandler.writeToFile();

    // 追加新内容
    fileHandler.appendToFile();

    return 0;
}

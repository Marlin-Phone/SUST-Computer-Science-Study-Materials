package java实验;
// 1.安装jdk，设置环境变量，配置java集成开发环境；

// 2.编写程序解决“百钱买百鸡”问题。公鸡五钱一只，母鸡三钱一只，小鸡一钱三只，现有百钱欲买百鸡，共有多少种买法？

// 3.利用switch语句判断一周的第几天是星期几（第一天是星期日，第二天是星期一，第三天是星期二，以此类推）。

// 4.定义一个计算器类，该类中包含加、减、乘、除4个静态方法，并定义一个测试类，调用对应的方法进行四则运算。

// 5.在类中定义一个静态方法printTree打印一颗树,该方法没有返回值，需要一个整形参数number定义树的高度,在主方法中调用这个方法，number值为5和10时得到下图的结果。

// 输出hello world
public class lab1 {
    // 第二题
    public static void buyChicken() {
        System.out.println("百钱买百鸡解法: ");
        int count = 0;
        for (int i = 0; i <= 20; i++) {
            for (int j = 0; j <= 33; j++) {
                int k = 100 - i - j; // 小鸡总数
                if (k % 3 == 0 && 5 * i + 3 * j + k / 3 == 100) {
                    System.out.printf("公鸡:%2d只, 母鸡:%2d只, 小鸡:%2d只\n", i, j, k);
                    count++;
                }
            }
        }
        System.out.println("共有" + count + "种买法。");
    }

    // 第三题
    public static void checkWeekDay(int day) {
        String weekDay;
        switch (day) {
            case 1:
                weekDay = "星期日";
                break;
            case 2:
                weekDay = "星期一";
                break;
            case 3:
                weekDay = "星期二";
                break;
            case 4:
                weekDay = "星期三";
                break;
            case 5:
                weekDay = "星期四";
                break;
            case 6:
                weekDay = "星期五";
                break;
            case 7:
                weekDay = "星期六";
                break;
            default:
                weekDay = "输入错误";
                break;
        }
        System.out.println("今天是" + weekDay);
    }

    // 第四题
    static class Calculator {
        public static double add(double a, double b) {
            return a + b;
        }

        public static double substract(double a, double b) {
            return a - b;
        }

        public static double multiply(double a, double b) {
            return a * b;
        }

        public static double divide(double a, double b) {
            if (b == 0) {
                throw new ArithmeticException("除数不能为0");
            }
            return a / b;
        }
    }

    public static void printTree(int number) {
        System.out.println("树高" + number + ":");
        // 打印树冠
        for (int i = 0; i < number; i++) {
            System.out.println(" ".repeat(number - i - 1) + "*".repeat(2 * i + 1));
        }
        // 打印树干
        for (int i = 0; i < 2; i++) {
            System.out.println(" ".repeat(number - 1) + "|");
        }
        System.out.println();
    }

    public static void main(String[] args) {
        // 第二题
        buyChicken();

        // 第三题
        checkWeekDay(3);
        checkWeekDay(7);

        // 第四题
        System.out.println("计算机测试: ");
        System.out.println("8 + 5 = " + Calculator.add(8, 5));
        System.out.println("8 - 5 = " + Calculator.substract(8, 5));
        System.out.println("8 * 5 = " + Calculator.multiply(8, 5));
        System.out.println("8 / 5 = " + Calculator.divide(8, 5));

        // 第五题
        printTree(5);
        printTree(10);
    }
}
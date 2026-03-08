// 1.设计一个抽象类图形类，在该类中包含有至少三个抽象方法，分别用于求周长、求面积，
// 以及对图形进行描述（如，“这是**形状，周长是**，面积是**”），
// 分别定义圆形类、长方形类、等边三角形类来继承图形类，实现上述三个方法，并创建实例验证。
// 2.定义一个抽象接口，该接口用于求和与统计数量。定义两个奇数类与偶数类实现上述接口，
// 分别可以求100以内的奇数的和，统计100以内的奇数个数，以及求100以内的偶数的和，
// 统计100以内的偶数个数。
// 3.定义一个抽象类动物类，同时定义抽象接口：
// 进食接口、睡觉接口、思考接口、说话接口、行走接口、游泳接口、飞翔的接口。
// 分别定义猫类、人类、鸟类、鱼类继承动物类，同时，根据实际情况，选择性实现上述接口，并创建实例验证。
// 4.编写一个类，实现银行账户，并完成程序的测试：
// (1)设置的属性有“账号”、 “储户姓名”、“地址”以及“存款余额”；
// (2)设置的方法有“存款”、“取款”、“查询”、“计算利息”、“累加利息”；
// (3)给类增加一个静态属性“最小余额”和一个用来修改这个最小余额属性的方法；
// (4)给类增加一个静态属性“活期利息”和封装这个数据的对应方法；

package java实验;

import java.text.DecimalFormat;

public class lab3 {

    // 题目1：抽象图形类及实现
    abstract static class Shape {
        public abstract double getPerimeter();

        public abstract double getArea();

        public abstract String getDescription();
    }

    static class Circle extends Shape {
        private double radius;

        public Circle(double radius) {
            this.radius = radius;
        }

        @Override
        public double getPerimeter() {
            return 2 * Math.PI * radius;
        }

        @Override
        public double getArea() {
            return Math.PI * radius * radius;
        }

        @Override
        public String getDescription() {
            return String.format("圆形 半径%.2f，周长%.2f，面积%.2f",
                    radius, getPerimeter(), getArea());
        }
    }

    static class Rectangle extends Shape {
        private double length;
        private double width;

        public Rectangle(double length, double width) {
            this.length = length;
            this.width = width;
        }

        @Override
        public double getPerimeter() {
            return 2 * (length + width);
        }

        @Override
        public double getArea() {
            return length * width;
        }

        @Override
        public String getDescription() {
            return String.format("长方形 长%.2f宽%.2f，周长%.2f，面积%.2f",
                    length, width, getPerimeter(), getArea());
        }
    }

    static class EquilateralTriangle extends Shape {
        private double side;

        public EquilateralTriangle(double side) {
            this.side = side;
        }

        @Override
        public double getPerimeter() {
            return 3 * side;
        }

        @Override
        public double getArea() {
            return (Math.sqrt(3) / 4) * side * side;
        }

        @Override
        public String getDescription() {
            return String.format("等边三角形 边长%.2f，周长%.2f，面积%.2f",
                    side, getPerimeter(), getArea());
        }
    }

    // 题目2：数字处理接口及实现
    interface NumberProcessor {
        long sum();

        int count();
    }

    static class OddNumberProcessor implements NumberProcessor {
        @Override
        public long sum() {
            long sum = 0;
            for (int i = 1; i < 100; i += 2)
                sum += i;
            return sum;
        }

        @Override
        public int count() {
            return 50;
        }
    }

    static class EvenNumberProcessor implements NumberProcessor {
        @Override
        public long sum() {
            long sum = 0;
            for (int i = 2; i <= 100; i += 2)
                sum += i;
            return sum;
        }

        @Override
        public int count() {
            return 50;
        }
    }

    // 题目3：动物类及接口系统
    abstract static class Animal {
        protected String name;

        public Animal(String name) {
            this.name = name;
        }
    }

    interface Eat {
        void eating();
    }

    interface Sleep {
        void sleeping();
    }

    interface Think {
        void thinking();
    }

    interface Speak {
        void speaking();
    }

    interface Walk {
        void walking();
    }

    interface Swim {
        void swimming();
    }

    interface Fly {
        void flying();
    }

    static class Cat extends Animal implements Eat, Sleep, Walk {
        public Cat(String name) {
            super(name);
        }

        public void eating() {
            System.out.println(name + "在吃鱼");
        }

        public void sleeping() {
            System.out.println(name + "蜷缩着睡觉");
        }

        public void walking() {
            System.out.println(name + "优雅地行走");
        }
    }

    static class Human extends Animal implements Eat, Sleep, Think, Speak, Walk {
        public Human(String name) {
            super(name);
        }

        public void eating() {
            System.out.println(name + "用筷子吃饭");
        }

        public void sleeping() {
            System.out.println(name + "躺在床上睡觉");
        }

        public void thinking() {
            System.out.println(name + "正在思考哲学问题");
        }

        public void speaking() {
            System.out.println(name + "说：你好！");
        }

        public void walking() {
            System.out.println(name + "直立行走");
        }
    }

    static class Bird extends Animal implements Eat, Fly {
        public Bird(String name) {
            super(name);
        }

        public void eating() {
            System.out.println(name + "啄食虫子");
        }

        public void flying() {
            System.out.println(name + "在天空翱翔");
        }
    }

    static class Fish extends Animal implements Eat, Swim {
        public Fish(String name) {
            super(name);
        }

        public void eating() {
            System.out.println(name + "吞食水藻");
        }

        public void swimming() {
            System.out.println(name + "摆尾游泳");
        }
    }

    // 题目4：银行账户类
    static class BankAccount {
        private String accountNumber;
        private String name;
        private String address;
        private double balance;

        private static double minBalance = 0;
        private static double interestRate = 0.0035;

        public BankAccount(String accountNumber, String name, String address) {
            this.accountNumber = accountNumber;
            this.name = name;
            this.address = address;
            this.balance = 0;
        }

        // 存款
        public void deposit(double amount) {
            if (amount > 0)
                balance += amount;
        }

        // 取款
        public boolean withdraw(double amount) {
            if (balance - amount >= minBalance) {
                balance -= amount;
                return true;
            }
            return false;
        }

        // 查询余额
        public double getBalance() {
            return balance;
        }

        // 计算利息
        public double calculateInterest() {
            return balance * interestRate;
        }

        // 利息累加
        public void addInterest() {
            balance += calculateInterest();
        }

        // 静态方法
        public static void setMinBalance(double amount) {
            minBalance = amount;
        }

        public static void setInterestRate(double rate) {
            interestRate = rate;
        }
    }

    public static void main(String[] args) {
        // 题目1测试
        Shape circle = new Circle(5);
        Shape rectangle = new Rectangle(4, 6);
        Shape triangle = new EquilateralTriangle(3);
        System.out.println(circle.getDescription());
        System.out.println(rectangle.getDescription());
        System.out.println(triangle.getDescription());

        // 题目2测试
        NumberProcessor odd = new OddNumberProcessor();
        NumberProcessor even = new EvenNumberProcessor();
        System.out.println("\n奇数统计：总数" + odd.count() + " 总和" + odd.sum());
        System.out.println("偶数统计：总数" + even.count() + " 总和" + even.sum());

        // 题目3测试
        Cat tom = new Cat("汤姆");
        tom.eating();
        tom.walking();

        Human alice = new Human("爱丽丝");
        alice.thinking();
        alice.speaking();

        Bird sparrow = new Bird("麻雀");
        sparrow.flying();

        Fish nemo = new Fish("尼莫");
        nemo.swimming();

        // 题目4测试
        BankAccount.setMinBalance(100);
        BankAccount account = new BankAccount("62258888", "张三", "北京");
        account.deposit(5000);
        System.out.println("\n当前余额：" + account.getBalance());
        account.addInterest();
        System.out.println("加利息后余额：" + new DecimalFormat("#.00").format(account.getBalance()));
    }
}

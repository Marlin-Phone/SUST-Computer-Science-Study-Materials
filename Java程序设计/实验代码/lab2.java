package java实验;

import java.util.*;

// 1. 定义一个计算机类，要求该类中至少包含3个私有的属性（为每个属性定义设置和获取方法）,
// 该类中至少包含两个构造方法（一个无参，一个有参），
// 以及包含2-4个方法来描述计算机对象的行为（其中一个方法要能打印输出计算机对象的所有属性值）。
public class lab2 {
    // 题目一
    static class Computer {
        private String brand;
        private String model;
        private double price;

        public Computer() {
        }

        public Computer(String brand, String model, double price) {
            this.brand = brand;
            this.model = model;
            this.price = price;
        }

        public String getBrand() {
            return brand;
        }

        public void setBrand(String brand) {
            this.brand = brand;
        }

        public String getModel() {
            return model;
        }

        public void setModel(String model) {
            this.model = model;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public void powerOn() {
            System.out.println(model + " 开机成功！");
        }

        public void runProgram(String program) {
            System.out.println("正在运行: " + program);
        }

        public void printInfo() {
            System.out.println(this);
        }

        @Override
        public String toString() {
            return String.format("品牌: %s 型号: %s 价格: %.2f", brand, model, price);
        }
    }

    // 题目二
    static class ArrayOperations {
        public static String[] reverseSortStringArrays(String[] arr1, String[] arr2) {
            // 字符串数组逆序排序
            List<String> merged = new ArrayList<>(Arrays.asList(arr1));
            merged.addAll(Arrays.asList(arr2));
            merged.sort(Collections.reverseOrder());
            return merged.toArray(new String[0]);
        }

        // 整数数组交集
        public static Integer[] findIntIntersection(int[] arr1, int[] arr2) {
            Set<Integer> set1 = new HashSet<>();
            Set<Integer> result = new HashSet<>();
            for (int num : arr1)
                set1.add(num);
            for (int num : arr2)
                if (set1.contains(num))
                    result.add(num);
            return result.toArray(new Integer[0]);
        }

        // 浮点型数组并集(处理精度误差)
        public static Double[] findFloatUnion(double[] arr1, double[] arr2) {
            Set<Double> set = new HashSet<>();
            for (double num : arr1)
                set.add(Math.round(num * 1000.0) / 1000.0);
            for (double num : arr2)
                set.add(Math.round(num * 1000.0) / 1000.0);
            return set.toArray(new Double[0]);
        }
    }

    // 题目3：学生信息类
    static class Student {
        private String sNO;
        private String sName;
        private String sSex;
        private int sAge;
        private double sJava;

        // 带参构造
        public Student(String no, String name, String sex, int age, double javaScore) {
            sNO = no;
            sName = name;
            sSex = sex;
            sAge = age;
            sJava = javaScore;
        }

        // Getter/Setter方法
        public String getNo() {
            return sNO;
        }

        public void setNo(String no) {
            sNO = no;
        }

        public String getName() {
            return sName;
        }

        public void setName(String name) {
            sName = name;
        }

        public String getSex() {
            return sSex;
        }

        public void setSex(String sex) {
            sSex = sex;
        }

        public int getAge() {
            return sAge;
        }

        public void setAge(int age) {
            sAge = age;
        }

        public double getJava() {
            return sJava;
        }

        public void setJava(double javaScore) {
            sJava = javaScore;
        }

        @Override
        public String toString() {
            return String.format("学号：%s 姓名：%s 性别：%s 年龄：%d Java成绩：%.1f",
                    sNO, sName, sSex, sAge, sJava);
        }
    }

    public static void main(String[] args) {
        // 测试题目1
        Computer myPC = new Computer("Dell", "XPS 15", 12999.99);
        myPC.powerOn();
        myPC.runProgram("IntelliJ IDEA");
        myPC.printInfo();

        // 测试题目2
        String[] arr1 = { "Apple", "Banana" };
        String[] arr2 = { "Cherry", "Date" };
        System.out.println("\n逆序排序结果：" + Arrays.toString(
                ArrayOperations.reverseSortStringArrays(arr1, arr2)));

        int[] nums1 = { 1, 2, 3, 4 };
        int[] nums2 = { 3, 4, 5, 6 };
        System.out.println("整型数组交集：" + Arrays.toString(
                ArrayOperations.findIntIntersection(nums1, nums2)));

        double[] doubles1 = { 1.1, 2.2 };
        double[] doubles2 = { 2.2, 3.3 };
        System.out.println("浮点型数组并集：" + Arrays.toString(
                ArrayOperations.findFloatUnion(doubles1, doubles2)));

        // 测试题目3
        Student[] students = {
                new Student("001", "张三", "男", 20, 89.5),
                new Student("002", "李四", "女", 19, 92.0),
                new Student("003", "王五", "男", 21, 85.5),
                new Student("004", "赵六", "女", 20, 95.0),
                new Student("005", "陈七", "男", 22, 88.5)
        };

        double total = 0;
        double max = Double.MIN_VALUE;
        double min = Double.MAX_VALUE;

        System.out.println("\n学生信息：");
        for (Student s : students) {
            System.out.println(s);
            total += s.getJava();
            max = Math.max(max, s.getJava());
            min = Math.min(min, s.getJava());
        }

        System.out.printf("\n平均成绩：%.2f\n最高分：%.1f\n最低分：%.1f",
                total / students.length, max, min);
    }
}

// 2．定义一个类，该类中包含以下几个方法（静态）：
// 实现两个字符串数组的逆序排序，输出结果为字符串数组；
// 求两个整形数组的交集；
// 求两个浮点型数组的并集；

// 3．定义一个表示学生信息的类Student，要求如下：
// （1）类Student的成员变量：
// sNO 表示学号；sName表示姓名；sSex表示性别；sAge表示年龄；sJava：表示Java课程成绩。
// （2）类Student带参数的构造方法：
// 在构造方法中通过形参完成对成员变量的赋值操作。
// （3）类Student的方法成员：
// getNo（）：获得学号；
// getName（）：获得姓名；
// getSex（）：获得性别；
// getAge（）获得年龄；
// getJava（）：获得Java 课程成绩
// setNo（）：设置学号；
// setName（）：设置姓名；
// setSex（）：设置性别；
// setAge（）；设置年龄
// setJava（）：设置Java 课程成绩

// 根据类Student的定义，创建五个该类的对象，输出每个学生的信息，计算并输出这五个学生Java语言成绩的平均值，以及计算并输出他们Java语言成绩的最大值和最小值。

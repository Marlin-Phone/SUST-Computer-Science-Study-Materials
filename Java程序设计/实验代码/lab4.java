// 1.定义一个方法，根据用户身份证号码计算其年龄并输出。
// 2.采用Random类或者Math类随机生成一组随机数，存入List集合类(ArrayList、LinkedList等都可以)，并利用Iterator接口便利集合。
// 3.分别统计字符串中出现的大写字母、小写字母个数，以及
// 出现的数字字符以及其他字符的个数。
// 4. 编写一个程序,实现字符串大小写的转换并倒序输出。具体要求：(1)使用for循环将字符串从最后一个字符开始遍历。（2）遍历的当前字符如果是大写字符，就使用toLowerCase()方法将其转换为小写字符，反之则使用toUpperCase()方法将其转换为大写字符。（3）定义一个StringBuffer对象，调用append()方法依次添加遍历的字符，最后调用StringBuffer对象的toString( )方法，并将得到的结果输出。
// 注意：倒叙序出要单独写一个有参的方法，在主函数里调用该方法完成测试。

package java实验;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class lab4 {

    // 题目1：根据身份证计算年龄
    public static void calculateAge(String idCard) {
        if (idCard.length() != 15 && idCard.length() != 18) {
            System.out.println("无效的身份证号码");
            return;
        }

        String birthDateStr = idCard.length() == 18 ? idCard.substring(6, 14) : "19" + idCard.substring(6, 12);

        try {
            LocalDate birthDate = LocalDate.parse(birthDateStr,
                    DateTimeFormatter.ofPattern("yyyyMMdd"));
            LocalDate now = LocalDate.now();

            int age = now.getYear() - birthDate.getYear();
            if (now.getMonthValue() < birthDate.getMonthValue() ||
                    (now.getMonthValue() == birthDate.getMonthValue() &&
                            now.getDayOfMonth() < birthDate.getDayOfMonth())) {
                age--;
            }
            System.out.println("年龄：" + age);
        } catch (Exception e) {
            System.out.println("身份证号码格式错误");
        }
    }

    // 题目2：生成并遍历随机数集合
    public static void processRandomNumbers(int count) {
        List<Integer> numbers = new ArrayList<>();
        Random random = new Random();

        for (int i = 0; i < count; i++) {
            numbers.add(random.nextInt(100));
        }

        System.out.print("随机数：");
        Iterator<Integer> it = numbers.iterator();
        while (it.hasNext()) {
            System.out.print(it.next() + " ");
        }
        System.out.println();
    }

    // 题目3：统计字符类型
    public static void countCharacters(String str) {
        int upper = 0, lower = 0, digit = 0, other = 0;

        for (char c : str.toCharArray()) {
            if (Character.isUpperCase(c)) {
                upper++;
            } else if (Character.isLowerCase(c)) {
                lower++;
            } else if (Character.isDigit(c)) {
                digit++;
            } else {
                other++;
            }
        }

        System.out.println("大写字母：" + upper);
        System.out.println("小写字母：" + lower);
        System.out.println("数字字符：" + digit);
        System.out.println("其他字符：" + other);
    }

    // 题目4：字符串转换并倒序输出
    public static String reverseAndConvertCase(String input) {
        StringBuffer sb = new StringBuffer();
        for (int i = input.length() - 1; i >= 0; i--) {
            char c = input.charAt(i);
            sb.append(Character.isUpperCase(c) ? Character.toLowerCase(c) : Character.toUpperCase(c));
        }
        return sb.toString();
    }

    public static void main(String[] args) {
        // 题目1测试
        System.out.println("-----身份证年龄计算-----");
        calculateAge("420106199901011234");
        calculateAge("420106990101123");

        // 题目2测试
        System.out.println("\n-----随机数处理-----");
        processRandomNumbers(10);

        // 题目3测试
        System.out.println("\n-----字符统计-----");
        countCharacters("Hello World! 2023 Java实验");

        // 题目4测试
        System.out.println("\n-----字符串转换-----");
        String result = reverseAndConvertCase("AbCdEfG123!");
        System.out.println("转换结果：" + result);
    }
}

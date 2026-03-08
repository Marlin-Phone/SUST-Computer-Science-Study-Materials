// (1)利用GUI设计实现一个计算器程序（注：至少要实现基本的加减乘除运算四则运算）。
// (2)设计一个关于文件操作的图形化应用程序，至少实现以下功能：
//  a)包含一个文本框以及添加按钮，在文本框中输入文字后，点击添加按钮可以在文件中写入文本框中的文字；
//   b)包含一个读取按钮，点击该按钮后，可以读取文件内容，并显示到文本框中。

package java实验;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;

public class lab5 {

    // 计算器实现
    static class Calculator extends JFrame {
        private JTextField display = new JTextField(20);
        private double currentValue = 0;
        private String pendingOperator = "";
        private boolean newNumber = true;

        public Calculator() {
            setTitle("计算器");
            setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            setLayout(new BorderLayout());

            JPanel buttonPanel = new JPanel(new GridLayout(4, 5, 5, 5));
            String[] buttons = {
                    "C", "/", "*", "-", "7",
                    "8", "9", "+", "4", "5",
                    "6", ".", "1", "2", "3",
                    "=", "0"
            };

            for (String btn : buttons) {
                JButton button = new JButton(btn);
                button.addActionListener(new ButtonClickListener());
                buttonPanel.add(button);
            }

            add(display, BorderLayout.NORTH);
            add(buttonPanel, BorderLayout.CENTER);
            pack();
            setSize(300, 400);
        }

        private class ButtonClickListener implements ActionListener {
            public void actionPerformed(ActionEvent e) {
                String command = e.getActionCommand();

                if (Character.isDigit(command.charAt(0)) || command.equals(".")) {
                    if (newNumber) {
                        display.setText("");
                        newNumber = false;
                    }
                    display.setText(display.getText() + command);
                } else if ("+-*/".contains(command)) {
                    currentValue = Double.parseDouble(display.getText());
                    pendingOperator = command;
                    newNumber = true;
                } else if (command.equals("=")) {
                    calculate();
                    pendingOperator = "";
                    newNumber = true;
                } else if (command.equals("C")) {
                    display.setText("0");
                    currentValue = 0;
                    pendingOperator = "";
                    newNumber = true;
                }
            }

            private void calculate() {
                double secondValue = Double.parseDouble(display.getText());
                switch (pendingOperator) {
                    case "+":
                        currentValue += secondValue;
                        break;
                    case "-":
                        currentValue -= secondValue;
                        break;
                    case "*":
                        currentValue *= secondValue;
                        break;
                    case "/":
                        if (secondValue != 0) {
                            currentValue /= secondValue;
                        }
                        break;
                }
                display.setText(String.valueOf(currentValue));
            }
        }
    }

    // 文件操作程序实现
    static class FileOperationApp extends JFrame {
        private JTextArea textArea = new JTextArea(10, 30);
        private final String FILE_PATH = "data.txt";

        public FileOperationApp() {
            setTitle("文件操作程序");
            setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            setLayout(new FlowLayout());

            JButton addBtn = new JButton("添加内容");
            JButton readBtn = new JButton("读取文件");

            addBtn.addActionListener(e -> writeToFile());
            readBtn.addActionListener(e -> readFromFile());

            add(new JScrollPane(textArea));
            add(addBtn);
            add(readBtn);
            pack();
            setSize(400, 300);
        }

        private void writeToFile() {
            try (FileWriter fw = new FileWriter(FILE_PATH, true);
                    BufferedWriter bw = new BufferedWriter(fw)) {
                bw.write(textArea.getText());
                bw.newLine();
                textArea.setText("");
                JOptionPane.showMessageDialog(this, "内容已保存！");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }

        private void readFromFile() {
            StringBuilder content = new StringBuilder();
            try (FileReader fr = new FileReader(FILE_PATH);
                    BufferedReader br = new BufferedReader(fr)) {
                String line;
                while ((line = br.readLine()) != null) {
                    content.append(line).append("\n");
                }
                textArea.setText(content.toString());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        // 运行计算器
        // SwingUtilities.invokeLater(() -> new Calculator().setVisible(true));

        // 运行文件操作程序（需要时取消注释）
        SwingUtilities.invokeLater(() -> new FileOperationApp().setVisible(true));
    }
}

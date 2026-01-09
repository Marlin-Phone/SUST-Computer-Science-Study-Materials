# 实验 2 预习报告

## 实验内容
斐波那契数列：求前 20 项（8086 汇编）。

## 程序代码
代码文件：`exp/exp02/prelab.asm`

程序会初始化 AX=1、BX=1，先输出前两个数，然后循环计算并通过 OUT 20h 输出每一项的低字节。

## 运行示例
在项目根目录运行：

  python main.py ./exp/exp02/prelab.asm -n

模拟器会在 I/O 端口 0x20 逐项输出 Fibonacci 序列的低字节。

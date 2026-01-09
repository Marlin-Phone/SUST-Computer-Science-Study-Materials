; exp01/prelab.asm
;  实验 1 预习：已知变量 x, y, z，求三个变量之和（8086 汇编）
NAME exp01_prelab
TITLE sum_x_y_z_prelab

ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    X DB  05h    ; 示例值 5
    Y DB  0Ah    ; 示例值 10
    Z DB  03h    ; 示例值 3
    SUM DW ?
DATA ENDS
 
CODE SEGMENT
START:  MOV AX,DATA
        MOV DS,AX

        ; 读取 x,y,z 并计算和，结果放入 sum
    MOV AL,X
    MOV BL,Y
        ADD AL,BL
    MOV BL,Z
        ADD AL,BL        ; AL = x+y+z (低 8 位)
        MOV AH,00H
    MOV SUM,AX     ; 保存结果（word）

        ; 将结果通过 OUT 20h 输出低字节（本 emulator 示例输出方法）
    OUT 20h,AL

        INT 3H           ; 结束程序
CODE ENDS
END START

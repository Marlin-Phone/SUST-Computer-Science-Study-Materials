; exp01/experiment.asm
;  实验 1 正式：
;  任务 1（必做）：已知变量 x, y, z，求三个变量之和并输出
;  任务 2（选做）：比较两个数的大小（输出标志：0=相等，1=A>B，2=A<B）
;  说明：
;    - 不使用子程序/函数，顺序直线式编写，少量标签仅用于分支跳转。
;    - 输出端口：20h 输出 sum 的低字节；21h 输出比较结果标志。

NAME exp01_experiment
TITLE exp01_sum_and_compare

ASSUME CS:CODE,DS:DATA

DATA SEGMENT
        ; 数据示例，可在报告中说明并修改为任意值
        X DB 07h          ; 被加数1
        Y DB 05h          ; 被加数2
        Z DB 09h          ; 被加数3

        A DB 0Ah          ; 比较用数 A（无符号）
        B DB 05h          ; 比较用数 B（无符号）

        SUM DW ?          ; 保存 x+y+z 的 16 位结果（低字节通过端口 20h 输出）
        CMP_FLAG DB ?     ; 比较结果标志：0=相等，1=A>B，2=A<B（通过端口 21h 输出）
DATA ENDS

CODE SEGMENT
START:
        ; 初始化数据段寄存器：让 DS 指向本文件 DATA 段
        MOV AX,DATA
        MOV DS,AX

; ------------------ 求和部分（必做） ------------------
        ; 目标：计算 X+Y+Z，结果放入 SUM（word），并通过端口 20h 输出低字节
        MOV AL,X          ; AL = X
        MOV BL,Y          ; BL = Y
        ADD AL,BL         ; AL = X + Y
        MOV BL,Z          ; BL = Z
        ADD AL,BL         ; AL = X + Y + Z（低 8 位）
        MOV AH,00H        ; 高字节清零（本简化版本未将进位并入 AH）
        MOV SUM,AX        ; SUM = AX（低字节即输出值）
        OUT 20h,AL        ; 输出 sum 的低字节到端口 20h

; ------------------ 比较部分（选做，直线简化版） ------------------
        ; 目标：比较 A 与 B（无符号）并输出标志到端口 21h
        ; 规则：0=相等，1=A>B，2=A<B
        MOV AL,A          ; AL = A
        CMP AL,B          ; 比较 A 与 B（无符号）
        MOV CMP_FLAG,02H  ; 先假定 A < B
        JE  .eq           ; 如果 A==B -> 置 0
        JA  .gt           ; 如果 A>B  -> 置 1
        JMP .out          ; 否则保持 2（A<B）
.eq:
        MOV CMP_FLAG,00H
        JMP .out
.gt:
        MOV CMP_FLAG,01H
.out:
        MOV AL,CMP_FLAG   ; AL = 比较结果标志
        OUT 21h,AL        ; 输出到端口 21h

        INT 3H            ; 程序结束（断点中断）
CODE ENDS
END START

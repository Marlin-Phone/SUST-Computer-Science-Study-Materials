; exp02/prelab.asm
;  实验 2 预习：斐波那契数列，求前 20 项（8086 汇编）
;  输出方式：通过 OUT 20h 端口依次输出每一项的低字节

NAME exp02_prelab
TITLE fibonacci_prelab

ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    CNT DB 18h    ; 循环次数：18（因为会先输出前两个数，再循环产生剩余 18 个，总共 20）
    RES DW 20 DUP(?) ; 可选：保存输出序列（这里仅作为占位）
DATA ENDS

CODE SEGMENT
START:  MOV AX,DATA
        MOV DS,AX

        MOV AX,0      ; F0 = 0
        MOV BX,1      ; F1 = 1

        ; 输出前两个
        OUT 20h,AL    ; 输出 F0 (低字节)
        OUT 20h,BL    ; 输出 F1 (低字节)

        LEA SI,RES
        MOV CL,CNT
L1:    ADD AX,BX     ; AX = AX + BX -> next Fibonacci
        MOV [SI],AX
        MOV AX,BX
        MOV BX,[SI]
        ; 输出新产生的项（低字节）
        OUT 20h,AL
        INC SI
        LOOP L1

        INT 3H
CODE ENDS
END START

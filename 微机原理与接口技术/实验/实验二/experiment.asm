; exp02/experiment.asm
;  实验 2 正式：
;  任务 1（必做）：斐波那契数列，求前 20 项并输出
;  任务 2（选做）：已知数组中有 10 个元素，统计正数、零、负数的个数并输出
;  说明：
;    - 不使用子程序，顺序执行两个任务
;    - 输出端口：20h 输出斐波那契数列各项的低字节
;               22h/23h/24h 分别输出正数/零/负数的个数
NAME exp02_experiment
TITLE exp02_fib_and_count

ASSUME CS:CODE,DS:DATA

DATA SEGMENT
    ; ---------- 斐波那契数列部分的数据 ----------
    FIB_NUMS DW 1, 1, 18 DUP(0)  ; 斐波那契数列前20项（使用16位字存储）
    CNT DB 12h           ; 循环计数：18（十进制），用于生成除前2项外的18项

    ; ---------- 统计正/零/负数部分的数据 ----------
    ; 示例数组（10 个带符号字节）
    ; 05h=5(正), 00h=0(零), 0FFh=-1(负), 07h=7(正), 0=0(零),
    ; 0F0h=-16(负), 01h=1(正), 0=0(零), 0FBh=-5(负), 10h=16(正)
    ARR DB  05h, 00h, 0FFh, 07h, 0, 0F0h, 01h, 0, 0FBh, 10h
    POS_COUNT DB 0       ; 正数计数器
    ZERO_COUNT DB 0      ; 零计数器
    NEG_COUNT DB 0       ; 负数计数器
DATA ENDS

CODE SEGMENT
START:
        ; 初始化数据段寄存器：让 DS 指向 DATA 段
        MOV AX,DATA          ; AX = DATA 段地址（不能直接 MOV DS,立即数）
        MOV DS,AX            ; DS = AX，此后可正确访问数据段变量

; ===================== 任务 1：斐波那契数列前 20 项 =====================
        ; 斐波那契数列定义：F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)
        ; 本程序生成前20项：F0, F1, F2, ..., F19
        ; 策略：先输出前2项（F0=0, F1=1），然后用循环生成后18项
        
        ; 手动设置前两个斐波那契数
        ;MOV WORD PTR [FIB_NUMS], 0   ; F(0) = 0
        ;MOV WORD PTR [FIB_NUMS+2], 1 ; F(1) = 1

        ; 初始化循环
        MOV CX, 12h                 ; 设置循环18次
        LEA SI, [FIB_NUMS+4]        ; SI指向FIB_NUMS[2]的地址，用于存储下一个数

FIB_LOOP:
        ; 计算 F(n) = F(n-1) + F(n-2)
        MOV AX, [SI-2]              ; AX = F(n-1)
        ADD AX, [SI-4]              ; AX = F(n-1) + F(n-2)
        MOV [SI], AX                 ; 存储 F(n)

        ADD SI, 2                   ; 移动到下一个字的位置
        LOOP FIB_LOOP               ; CX 自减，不为 0 则跳回 FIB_LOOP
        ; 循环结束，共输出 20 项斐波那契数

        ; 输出第20个斐波那契数到20h端口
        ; FIB_NUMS是字数组，第20个数的索引是19，偏移量是 19 * 2 = 38
        MOV AX, [FIB_NUMS+38]
        OUT 20h, AX                 ; 使用AX将16位数输出

; ===================== 任务 2：统计数组中正数/零/负数的个数 =====================
        ; 数组 ARR 有 10 个有符号字节，统计其中正数、零、负数各有多少
        ; 判断依据（有符号比较）：
        ;   - AL == 0 -> 零
        ;   - AL >  0 -> 正数（最高位=0，且非零）
        ;   - AL <  0 -> 负数（最高位=1，即 AL & 80h != 0）
        
        LEA SI,ARR           ; SI 指向数组 ARR 的首地址
        MOV CX,10            ; CX = 10，循环计数（数组有 10 个元素）
        XOR AL,AL            ; AL = 0（清零，用于后续清零计数器）
        XOR AH,AH            ; AH = 0（未使用，保持清零习惯）
        
        ; 初始化三个计数器为 0
        MOV POS_COUNT,AL     ; 正数计数 = 0
        MOV ZERO_COUNT,AL    ; 零计数 = 0
        MOV NEG_COUNT,AL     ; 负数计数 = 0

C_LOOP:                      ; 统计循环开始
        MOV AL,[SI]          ; AL = 当前数组元素（带符号字节）
        CMP AL,0             ; 比较 AL 与 0
        JE .is_zero          ; 若 AL == 0，跳到 .is_zero
        JL .is_neg           ; 若 AL <  0（有符号比较），跳到 .is_neg
        ; 否则 AL > 0（正数）
        INC POS_COUNT        ; 正数计数器 +1
        JMP .next            ; 跳到下一个元素
.is_zero:
        INC ZERO_COUNT       ; 零计数器 +1
        JMP .next
.is_neg:
        INC NEG_COUNT        ; 负数计数器 +1
.next:
        INC SI               ; SI 指向下一个数组元素
        LOOP C_LOOP          ; CX 自减，不为 0 则跳回 C_LOOP
        ; 循环结束，统计完成

        ; 输出统计结果到不同端口（便于区分查看）
        MOV AL,POS_COUNT     ; AL = 正数个数
        OUT 22h,AL           ; 通过端口 22h 输出正数个数
        MOV AL,ZERO_COUNT    ; AL = 零个数
        OUT 23h,AL           ; 通过端口 23h 输出零个数
        MOV AL,NEG_COUNT     ; AL = 负数个数
        OUT 24h,AL           ; 通过端口 24h 输出负数个数

        INT 3H               ; 断点中断，程序结束
CODE ENDS
END START

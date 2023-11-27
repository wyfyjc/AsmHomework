PUBLIC FillYear
PUBLIC FillTotal
PUBLIC FillPeople
PUBLIC CalcAvg
PUBLIC PrintNum16
PUBLIC PrintNum32
PUBLIC PrintEmpty32
PUBLIC DIV32
PUBLIC Disp

ASSUME CS:PROCSEG

PROCSEG SEGMENT
FillYear PROC FAR
  ; 将年份填入TABLE
  MOV SI, 0
  MOV DI, 0
  MOV CX, 21 ; 循环执行21次
  
MOVE:
  MOV AL, [SI]
  MOV ES:[DI], AL
  ADD DI, 1
  ADD SI, 1

  MOV AL, [SI]
  MOV ES:[DI], AL
  ADD DI, 1
  ADD SI, 1

  MOV AL, [SI]
  MOV ES:[DI], AL
  ADD DI, 1
  ADD SI, 1

  MOV AL, [SI]
  MOV ES:[DI], AL
  ADD DI, 13
  ADD SI, 1

  LOOP MOVE
  
  RET
FillYear ENDP

FillTotal PROC FAR
  ; 将总收入填入TABLE
  MOV SI, 84
  MOV DI, 5
  MOV CX, 21 ; 循环执行21次
  
FillOneTotal:
  MOV AX, [SI]
  MOV ES:[DI], AX
  ADD DI, 2
  ADD SI, 2

  MOV AX, [SI]
  MOV ES:[DI], AX
  ADD DI, 14
  ADD SI, 2

  LOOP FillOneTotal
  
  RET
FillTotal ENDP

FillPeople PROC FAR
  ; 将人数填入TABLE
  MOV SI, 168
  MOV DI, 10
  MOV CX, 21 ; 循环执行21次
  
FillOnePeople:
  MOV AX, [SI]
  MOV ES:[DI], AX
  ADD DI, 16
  ADD SI, 2

  LOOP FillOnePeople
  
  RET
FillPeople ENDP

CalcAvg PROC FAR
  ; 计算人均收入并填入TABLE
  MOV SI, 5
  MOV CX, 21 ; 循环执行21次
  
FillOneAvg:
  MOV AX, ES:[SI] ; 取出被除数低位
  MOV DX, ES:[SI+2] ; 取出被除数高位
  MOV BX, ES:[SI+5] ; 取出除数
  DIV BX
  MOV ES:[SI+8], AX ; 填入结果

  ADD SI, 16

  LOOP FillOneAvg
  
  RET
CalcAvg ENDP

PrintNum16 PROC FAR
; 将AX中的十六进制数转换为十进制数输出，并且补足空格以对齐
; 循环除10取余从低到高获取每一位十进制数
PUSH CX
MOV CX, 10        ; 除数
MOV DX, 0DH
PUSH DX           ; 结束标志
DIV_LOOP:
  MOV DX, 0       ; DX寄存器置0
  DIV CX          ; 将AX寄存器中的数值除以CX寄存器中的数值，商存储在AX寄存器中，余数存储在DX寄存器中
  ADD DL, '0'     ; 将余数转换为ASCII码
  PUSH DX         ; 将余数压入栈中，以便逆序输出
	CMP AX, 0       ; 商是否为0
	JNE DIV_LOOP    ; 商不为0，则继续循环

; 逐个逆序输出数字，并补足空格
  MOV CX, 9
PRINT_LOOP:
  POP DX          ; 弹出栈中的1个数
	CMP DX, 0DH     ; 判断是否为结束标志
	JE PrintEmpty16
  MOV AH, 2       ; 输出DL中的字符
  INT 21H
  LOOP PRINT_LOOP ; 继续循环

PrintEmpty16:
  ; 输出空格直到CX为0
  MOV DL, ' '
  MOV AH, 2
	INT 21H
  LOOP PrintEmpty16

  POP CX
  RET
PrintNum16 ENDP

PrintNum32 PROC FAR
; 将DX:AX中的十六进制数转换为十进制数输出，并且补足空格以对齐
; 循环除10取余从低到高获取每一位十进制数
PUSH CX
MOV BX, 0DH
PUSH BX           ; 结束标志
MOV BX, 10        ; 除数
DIV32_LOOP:
  CALL DIV32      ; DX:AX中的十六进制数除以BX，结果存入CX:AX，余数为DX
  ADD DL, '0'     ; 将余数转换为ASCII码
  PUSH DX         ; 将余数压入栈中，以便逆序输出
  MOV DX, CX      ; 整理出新的被除数
	CMP AX, 0       ; 商的低位是否为0
	JNE DIV32_LOOP  ; 商低位不为0，则继续循环
	CMP CX, 0       ; 商的高位是否为0
	JNE DIV32_LOOP  ; 商高位不为0，则继续循环  

; 逐个逆序输出数字，并补足空格
  MOV CX, 11
PRINT32_LOOP:
  POP DX          ; 弹出栈中的1个数
	CMP DX, 0DH     ; 判断是否为结束标志
	JE PrintEmpty32
  MOV AH, 2       ; 输出DL中的字符
  INT 21H
  LOOP PRINT32_LOOP ; 继续循环

PrintEmpty32:
  ; 输出空格直到CX为0
  MOV DL, ' '
  MOV AH, 2
	INT 21H
  LOOP PrintEmpty32

  POP CX
  RET
PrintNum32 ENDP

DIV32 PROC FAR
  ; 不会溢出的32位除法，被除数为DX:AX，除数为BX, 结果存入CX:AX
  PUSH AX
  ; 先除前16位（00:DX）
  MOV AX, DX
  MOV DX, 0
  DIV BX
  MOV CX, AX ; CX存高位商
  ; 再除后16位（高位余数DX:AX）
  POP AX
  DIV BX
  ; 结果为CX:AX，余数为DX
  RET
  ; 32 位((DX:AX)/16 位=16 位（商放于 AX 中，余数放于 DX 中）
DIV32 ENDP

Disp PROC FAR
  ; 输出TABLE
  PUSH CX
  MOV SI, 0
  MOV CX, 21 ; 外循环次数
LO:
  PUSH CX
  MOV CX, 5 ; 内循环次数
LI:
  MOV AH, 2
  MOV DL, ES:[SI]
  INT 21H
  ADD SI, 1

  LOOP LI ; 内循环结束

  INT 21H ; 输出空格控制格式美观
  INT 21H
  INT 21H
  INT 21H

  ; 输出32位总收入
  MOV AX, ES:[SI]
  MOV DX, ES:[SI+2]
  CALL PrintNum32
  ADD SI, 4

  MOV AH, 2
  MOV DL, ES:[SI]
  INT 21H
  ADD SI, 1

  ; 输出16位人数
  MOV AX, ES:[SI]
  CALL PrintNum16
  ADD SI, 2

  MOV AH, 2
  MOV DL, ES:[SI]
  INT 21H
  ADD SI, 1

  ; 输出16位平均收入
  MOV AX, ES:[SI]
  CALL PrintNum16
  ADD SI, 2

  MOV AH, 2
  MOV DL, ES:[SI]
  INT 21H
  ADD SI, 1

  ;输出换行
  MOV AH, 2
	MOV DL, 0AH
	INT 21H

  POP CX ; 还原外循环次数
  LOOP LO

  POP CX
  RET
Disp ENDP
PROCSEG ENDS
END
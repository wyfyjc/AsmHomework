NEWSTKSEG SEGMENT
  DB 100 DUP(0)
NEWSTKSEG ENDS

NEWDATASEG SEGMENT
  MSG1 db 'WHAT IS THE DATE?(MM/DD/YY)$'
  YEAR db 'YY$'
  MONTH db 'MM$'
  DAY db 'DD$'
NEWDATASEG ENDS

NEWCODESEG SEGMENT
  ASSUME CS:NEWCODESEG,SS:NEWSTKSEG,DS:NEWDATASEG
  
WaitEnter PROC
  CON:
  MOV AH, 1 ; 读取一个字符存入AL
  INT 21H
  CMP AL, 0DH ; 判断是否为回车
  JNE CON ; 不是回车则继续循环
  RET
WaitEnter ENDP

GetNum PROC
  ; 读取月份输入
  MOV AH, 1 ; 读取一个字符存入AL
  INT 21H
  MOV [MONTH], AL
  INT 21H
  MOV [MONTH+1], AL

  CALL WaitEnter ; 等待回车

  ; 读取日期输入
  MOV AH, 1 ; 读取一个字符存入AL
  INT 21H
  MOV [DAY], AL
  INT 21H
  MOV [DAY+1], AL

  CALL WaitEnter ; 等待回车

  ; 读取年份输入
  MOV AH, 1 ; 读取一个字符存入AL
  INT 21H
  MOV [YEAR], AL
  INT 21H
  MOV [YEAR+1], AL

  CALL WaitEnter ; 等待回车

 ; 输出换行
  MOV AH, 2
  MOV DL, 0AH
  INT 21H
  RET
GetNum ENDP

Disp PROC
; 输出年
  CMP BX, 1
  JNE DispMonth
  MOV AX, NEWDATASEG
  MOV DS, AX
  MOV AH, 9
  MOV DX, OFFSET YEAR
  INT 21H
  RET
DispMonth:
  ; 输出月
  CMP BX, 2
  JNE DispDay
  MOV AX, NEWDATASEG
  MOV DS, AX
  MOV AH, 9
  MOV DX, OFFSET MONTH
  INT 21H
  RET
DispDay:
  ; 输出日
  MOV AX, NEWDATASEG
  MOV DS, AX
  MOV AH, 9
  MOV DX, OFFSET DAY
  INT 21H
  RET
Disp ENDP

MAIN PROC FAR
; 输出"WHAT IS THE DATE?"和换行
MOV AX, NEWDATASEG
MOV DS, AX
MOV AH, 9
MOV DX, OFFSET MSG1
INT 21H
MOV AH, 2
MOV DL, 0AH
INT 21H

;输出响铃字符（会卡死所以注释掉了）
; MOV DX, 0
; MOV AH, 2
; MOV DL, 7
; INT 21H

;接收输入
CALL GetNum

;输出
MOV BX, 1

CALL Disp ; 输出年

MOV AH, 2
MOV DL, 2DH
INT 21H

MOV BX, 2
CALL Disp ; 输出月

MOV AH, 2
MOV DL, 2DH
INT 21H

MOV BX, 3
CALL Disp ; 输出日

MOV AX, 4C00H ; 退出程序
INT 21H

MAIN ENDP
NEWCODESEG ENDS
END MAIN
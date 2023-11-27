EXTERN FillYear:FAR
EXTERN FillTotal:FAR
EXTERN FillPeople:FAR
EXTERN CalcAvg:FAR
EXTERN PrintNum16:FAR
EXTERN PrintNum32:FAR
EXTERN PrintEmpty32:FAR
EXTERN DIV32:FAR
EXTERN Disp:FAR

NEWSTKSEG SEGMENT
  DB 100 DUP(0)
NEWSTKSEG ENDS

NEWDATASEG SEGMENT
  ; 以下是表示21年的21个字符串
  db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
  db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
  db '1993','1994','1995'
  
  ; 以下是表示21年公司总收的21个dword型数据
  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
        
  ; 以下是表示21年公司雇员人数的21个word型数据
  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,45257,17800 
NEWDATASEG ENDS

TABLE SEGMENT
  db 21 dup('year summ ne ?? ')
TABLE ENDS

NEWCODESEG SEGMENT
  ASSUME CS:NEWCODESEG,SS:NEWSTKSEG,DS:NEWDATASEG

MAIN PROC FAR
MOV AX, NEWDATASEG
MOV DS, AX ; 将数据段地址加载到DS寄存器
MOV AX, TABLE
MOV ES, AX ; TABLE段地址加载到ES寄存器

CALL FillYear

CALL FillTotal

CALL FillPeople

CALL CalcAvg

CALL Disp ; 输出TABLE

MOV AX, 4C00H ; 退出程序
INT 21H

MAIN ENDP
NEWCODESEG ENDS
END MAIN
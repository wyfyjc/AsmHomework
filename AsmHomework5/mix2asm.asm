section .text
global asmAdd

asmAdd:
    MOV EAX, ECX   ; 第一个参数使用ECX传递
    IMUL EAX, EDX  ; 第二个参数使用EDX传递，IMUL将两数相乘并将商存入目标操作数，返回值使用EAX传递
    RET
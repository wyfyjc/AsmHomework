section .text
global asmAdd

asmAdd:
    MOV EAX, ECX   ; ��һ������ʹ��ECX����
    IMUL EAX, EDX  ; �ڶ�������ʹ��EDX���ݣ�IMUL��������˲����̴���Ŀ�������������ֵʹ��EAX����
    RET
#include <stdio.h>
#include <conio.h>

int main() {
    int x = 0, y = 0, z = 0;

    printf("������һ��������");
    scanf("%d", &x);
    printf("��������һ��������");
    scanf("%d", &y);

    char c;
    while ((c = getchar()) != '\n' && c != EOF); // ��ջ�����

    // �������
    __asm__ volatile(
        ".intel_syntax noprefix\n\
        MOV EAX, %1     \n\
        MOV EBX, %2     \n\
        ADD EAX, EBX    \n\
        MOV %0, EAX     \n\
        .att_syntax"
        : "=r"(z)
        : "r"(x), "r"(y)
    );

    printf("%d+%d=%d\n", x, y, z);
    printf("��������˳�");
    _getch();
    return 0;
}
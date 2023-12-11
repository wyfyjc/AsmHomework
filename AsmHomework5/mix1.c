#include <stdio.h>
#include <conio.h>

int main() {
    int x = 0, y = 0, z = 0;

    printf("请输入一个整数：");
    scanf("%d", &x);
    printf("请再输入一个整数：");
    scanf("%d", &y);

    char c;
    while ((c = getchar()) != '\n' && c != EOF); // 清空缓冲区

    // 内联汇编
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
    printf("按任意键退出");
    _getch();
    return 0;
}
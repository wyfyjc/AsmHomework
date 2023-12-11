#include <stdio.h>
#include <conio.h>

extern int asmAdd(int a, int b); // 声明汇编函数

int main() {
    int x = 0, y = 0, z = 0;

    printf("请输入一个整数：");
    scanf("%d", &x);
    printf("请再输入一个整数：");
    scanf("%d", &y);

    char c;
    while ((c = getchar()) != '\n' && c != EOF); // 清空缓冲区

    z = asmAdd(x, y); // 调用汇编函数

    printf("%d*%d=%d\n", x, y, z);
    printf("按任意键退出");
    _getch();
    return 0;
}
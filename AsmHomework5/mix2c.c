#include <stdio.h>
#include <conio.h>

extern int asmAdd(int a, int b); // ������ຯ��

int main() {
    int x = 0, y = 0, z = 0;

    printf("������һ��������");
    scanf("%d", &x);
    printf("��������һ��������");
    scanf("%d", &y);

    char c;
    while ((c = getchar()) != '\n' && c != EOF); // ��ջ�����

    z = asmAdd(x, y); // ���û�ຯ��

    printf("%d*%d=%d\n", x, y, z);
    printf("��������˳�");
    _getch();
    return 0;
}
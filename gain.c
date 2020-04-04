#include <stdio.h>

int x;
int y;
int a = 1;
int b = 0;

int gain(void)
{
    printf("Hello gain\n");
    //printf("x in gain\n", *x);
    y = x * 2;
    return 0;
}

int init(void)
{
    x = 1;
    y = 0;
    printf("val_init_x = %d\n", x);
    printf("addr_init_x = %d\n", &x);
    return 0;
}
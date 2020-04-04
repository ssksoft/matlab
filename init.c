#include <stdio.h>

int x;
int y;

int init(void)
{
    x = 0;
    y = 0;
    printf("val_init_x = %d\n", x);
    printf("addr_init_x = %d\n", &x);
    return 0;
}
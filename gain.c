#include <stdio.h>

extern int x;
extern int y;
int gain(void)
{
    printf("Hello gain\n");
    //printf("x in gain\n", *x);
    y = x * 2;
    return 0;
}

#include <stdio.h>
#include <windows.h>
#define GETSYMBOLADDR GetProcAddress
#define LOADLIB LoadLibrary
#define CLOSELIB FreeLibrary

int *x_ptr;
int *y_ptr;
int (*gain)(void);
int (*init)(void);
void *handleLib;
int main(void)
{

    printf("HelloMain\n");

    handleLib = LOADLIB("gain.dll");
    init = (int (*)(void))GETSYMBOLADDR(handleLib, "init");
    gain = (int (*)(void))GETSYMBOLADDR(handleLib, "gain");
    x_ptr = (int *)GETSYMBOLADDR(handleLib, "x");
    y_ptr = (int *)GETSYMBOLADDR(handleLib, "y");

    printf("addr_x = %d\n", x_ptr);
    printf("val_x = %d\n", *x_ptr);

    if (init && gain)
    {
        printf("notnull\n");
        init();
        printf("val_init_x in main = %d\n", *x_ptr);
        *x_ptr = 2;
        gain();
    }

    printf("---Fin---\n");
    printf("ans = %d\n", *y_ptr);
    return (CLOSELIB(handleLib));
}
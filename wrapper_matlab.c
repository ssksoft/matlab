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

int wrapper_matlab(int *x, int *y)
{
    //a
    handleLib = LOADLIB("gain.dll");
    init = (int (*)(void))GETSYMBOLADDR(handleLib, "init");
    gain = (int (*)(void))GETSYMBOLADDR(handleLib, "gain");
    x_ptr = (int *)GETSYMBOLADDR(handleLib, "x");
    y_ptr = (int *)GETSYMBOLADDR(handleLib, "y");

    if (init && gain)
    {
        init();
        *x_ptr = *x;
        gain();
        *y = *y_ptr;
    }
    return (CLOSELIB(handleLib));
}
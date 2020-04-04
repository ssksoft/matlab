#include<stdio.h>

int x;
int y;
extern int gain();


int main(void){
    x=1;
    gain();
    printf("ans = %d\n",y);
}
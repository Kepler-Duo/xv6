#include "types.h"
#include "user.h"
#define N 1e9

int COUNT = 0;
int fib(int x)
{
    if(x <= 2) return x;
    return fib(x-1)+fib(x-2);
}
void func(void* t_num)
{
    int i;
    for (i = 0; i < 3; i++)
    {
        int c = N; while(c--);
        COUNT++;
        int n = 3 * (int)t_num + i + c + 2;
        printf(0, "thread num: %d, count: %d, fib(%d) = %d\n", (int)t_num, COUNT, n, fib(n));
    }
    exit();
}

int main(int argc, char* argv[])
{
    int tids[3];
    int i;
    for (i = 0; i < 3; i++)
    {
        void *stack = malloc(4096);
        tids[i] = clone(func, (void*)i, stack);
    }

    for(i=0; i<3; i++)
    {
        join(tids[i]);
    }
    exit();
    return 0;
}
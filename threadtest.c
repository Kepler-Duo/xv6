#include "types.h"
#include "user.h"

int global = 0;
int fib(int x)
{
    if(x <= 2) return x;
    return fib(x-1)+fib(x-2);
}
void func(void* t_num)
{
    int i;
    for (i = 0; i < 5; i++)
    {
        int c = 1145141919; while(c--);
        global++;
        int n = 5 * (int)t_num + i + 2 + c;
        printf(0, "thread num: %d, global: %d, fib(%d) = %d\n", (int)t_num, global, n, fib(n));
    }
    exit();
}

int main(int argc, char* argv[])
{
    int tids[5];
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
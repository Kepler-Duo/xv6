#include "types.h"
#include "stat.h"
#include "user.h"

int main() {
    int n = 692;
    char* mem = (char*)malloc(4096 * n);
    if (mem == 0){
        printf(1, "malloc failed\n");
        exit();
    }

    for (int i = 0; i < n*4096; i++) {
        if (!(i % 4096))
            printf(1, "write page: %d, data: %d\n", i/4096, i/4096);
        mem[i] = i/4096;
    }
    printf(1, "write success\n\n");

    for (int i = 0; i < 5*4096; i++)
        if (!(i % 4096))
            printf(1, "read page %d, data: %d\n", i/4096, mem[i]);
    
    exit();
}
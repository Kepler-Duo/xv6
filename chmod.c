#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char* argv[]) {
    if(argc <= 2){
        printf(1, "too many arguments!\n");
        exit();
    }
    chmod(argv[1], atoi(argv[2]));
    exit();
}
// gcc -m32 -o env env.c
// because no ASLR, env vars will be located at the same place on the stack
// (we correct for program name length)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("./env VARIABLE /target/path\n");
        return 1;
    }
    const char *p = getenv(argv[1]);
    size_t our_len = strlen(argv[0]);
    size_t target_len = strlen(argv[2]);

    printf("%s is at %p\n", argv[1], p + our_len - target_len);
}

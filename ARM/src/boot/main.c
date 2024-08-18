#include <unistd.h>

int main() {
    char str[] = "Hello, world!\n";
    write(1, str, sizeof(str));
    return 0;
}
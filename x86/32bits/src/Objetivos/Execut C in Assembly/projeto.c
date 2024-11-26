#include <stdio.h>

int * soma(int a, int b) {
    return a + b;
}

void print() {
    printf("hello world\n");
}

const char * texto()
{
    return "hello\n";
}

int main() {
    int num = 10;
    char str[20];
    sprintf(str, "%d", num);
    printf("A soma é: %s\n", str);
    return 0;
}
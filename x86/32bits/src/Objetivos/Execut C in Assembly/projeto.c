#include <stdio.h>

int soma(int a, int b) {
    return a + b;
}

void print() {
    printf("hello world\n");
}

const char * texto()
{
    return "hello\n";
}

char * somaString(int a, int b) {
    int num = a + b;
    char str[20];
    sprintf(str, "%d", num);
    // printf("A soma é: %s\n", str);
    return str;
}
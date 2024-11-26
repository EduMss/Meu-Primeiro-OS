#include <stdio.h>
#include <stdlib.h>

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
    itoa(num, str, 10); // Converte num para uma string decimal e armazena em str
    // sprintf(str, "%d", num);
    // printf("A soma é: %s\n", str);
    return str;
}
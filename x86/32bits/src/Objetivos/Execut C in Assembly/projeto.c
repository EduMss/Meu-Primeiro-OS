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

int somaString(int a, int b) {
    int num = a + b;
    char str[20];

    itoa(num, str, 10); // Converte num para uma string decimal e armazena em str

    printf("O valor de num em string é: %s\n", str);
    return 0;
}
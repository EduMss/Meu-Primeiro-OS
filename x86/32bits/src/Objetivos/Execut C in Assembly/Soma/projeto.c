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

int somaPrint(int a, int b) {
    int num = a + b;
    char str[20];

    sprintf(str, "%d", num); // Converte num para uma string decimal e armazena em str

    printf("O valor de num em string é: %s\n", str);
    return 0;
}

const char* somaString(int a, int b) {
    static char str[20]; // Array estático para garantir que a string persista após a função terminar
    int num = a + b;

    sprintf(str, "%d", num);

    return str;
}
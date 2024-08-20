#include <stdint.h>

#define UART0_BASE 0x09000000
#define UARTFR      (UART0_BASE + 0x18)
#define UARTFR_TXFF (1 << 5)
#define UARTDR      (UART0_BASE + 0x00)

volatile unsigned int* uart0_fr = (unsigned int*)UARTFR;
volatile unsigned int* uart0_dr = (unsigned int*)UARTDR;

void putchar(char c) {
    while (*uart0_fr & UARTFR_TXFF);
    *uart0_dr = (unsigned int)c;
}

void puts(const char* str) {
    while (*str) {
        putchar(*str++);
    }
}

void main() {
    puts("Hello World\n");
    while (1);
}

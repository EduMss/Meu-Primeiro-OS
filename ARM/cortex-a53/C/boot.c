#include <stdint.h>

// Definições para o UART
#define UART0_BASE 0x09000000
#define UARTFR      (UART0_BASE + 0x18)
#define UARTFR_TXFF (1 << 5)
#define UARTDR      (UART0_BASE + 0x00)

volatile unsigned int* uart0_fr = (unsigned int*)UARTFR;
volatile unsigned int* uart0_dr = (unsigned int*)UARTDR;

// Função para escrever um caractere
static void uart_putchar(char c) {
    while (*uart0_fr & UARTFR_TXFF);  // Espera até que o buffer não esteja cheio
    *uart0_dr = (unsigned int)c;
}

// Função para escrever uma string
static void uart_puts(const char* str) {
    while (*str) {
        uart_putchar(*str++);
    }
}

void main() {
    uart_puts("Hello World\n");
    while (1);
}

void _start(void) {
    // Seu código de inicialização aqui
    uart_puts("Hello World\n");
    while (1) {
        // Loop infinito para bootloader
    }
}

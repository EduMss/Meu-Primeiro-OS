.global _start

// Definições para o UART
.equ UART0_BASE, 0x09000000
.equ UARTFR, 0x18
.equ UARTFR_TXFF, 0x20
.equ UARTDR, 0x00

.section .data
message:
    .asciz "Hello World\n"

.section .text
_start:
    // Carrega o endereço da mensagem
    ldr x0, =message

    // Chama a função para imprimir a string
    bl print_string

    // Loop infinito
    b .

print_string:
    // Carrega o próximo byte da string
    ldrb w1, [x0], #1

    // Verifica se é o final da string
    cmp w1, #0
    beq end_print

wait_uart:
    // Carrega o endereço base do UART0
    ldr x2, =UART0_BASE
    ldr w3, [x2, #UARTFR]
    // Verifica se o buffer está cheio
    tst w3, #UARTFR_TXFF
    b.ne wait_uart

    // Escreve o byte no UART0
    strb w1, [x2, #UARTDR]
    b print_string

end_print:
    // Sai da execução
    mov x8, #93          // Número da chamada do sistema para terminar o programa
    mov x0, #0           // Código de saída
    svc #0               // Chama o sistema

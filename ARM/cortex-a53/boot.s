.global _start

.equ UART0_BASE, 0x3F215040
.equ UARTFR, 0x18
.equ UARTFR_TXFF, 0x20
.equ UARTDR, 0x00

.section .text
_start:
    ldr r0, =message          @ Carrega o endereço da mensagem
    bl print_string           @ Chama a função para imprimir a string
    b .

print_string:
    ldrb r1, [r0], #1         @ Carrega o próximo byte da string
    cmp r1, #0                @ Verifica se é o final da string
    beq end_print             @ Se for o final, sai da função

wait_uart:
    ldr r2, =UART0_BASE       @ Carrega o endereço base do UART0
    ldr r3, [r2, #UARTFR]     @ Carrega o status do UART0
    tst r3, #UARTFR_TXFF      @ Verifica se o buffer está cheio
    bne wait_uart             @ Espera se o buffer estiver cheio

    strb r1, [r2, #UARTDR]    @ Escreve o byte no UART0
    b print_string            @ Imprime o próximo caractere

end_print:
    bx lr                     @ Retorna

.section .data
message:
    .asciz "Hello World\n"

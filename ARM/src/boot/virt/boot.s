.section .text
.global _start

UART0_BASE = 0x09000000
UART0_DR = UART0_BASE + 0x00

_start:
    ldr r0, =message
    bl print_string
    b .

print_string:
    mov r1, r0
    loop:
        ldrb r2, [r1], #1
        cmp r2, #0
        beq end
        bl putchar
        b loop
    end:
        bx lr

putchar:
    ldr r1, =UART0_DR
    strb r2, [r1]
    bx lr

.section .data
message:
    .asciz "Hello World\n"

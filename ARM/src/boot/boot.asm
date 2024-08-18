.section .text
.global _start

_start:
    mov r0, 0x01
    ldr r1, message
    mov r2, 0x10
    mov r7, 0x04
    svc 0

    mov r7, 0x01
    mov r0, 0x00
    svc 0

.section .data
message:
    .asciz "Hello, ARM World!\n"

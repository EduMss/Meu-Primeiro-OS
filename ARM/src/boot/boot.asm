.section .text
.global _start

_start:
    mov r0, #1
    ldr r1, =message
    mov r2, #16
    mov r7, #4
    svc #0

    mov r7, #1
    mov r0, #0
    svc #0

.section .data
message:
    .asciz "Hello, ARM World!\n"

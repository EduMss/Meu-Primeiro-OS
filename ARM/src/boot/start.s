.global _start

_start:
    .data
    msg: .asciz "Hello, world!\n"
    .text
    ldr r0, =1
    ldr r1, =msg
    ldr r2, =14
    mov r7, #4
    svc 0
    mov r7, #1
    mov r0, #0
    svc 0

.end

.section .text
.global _start

_start:
    mov r0, #1              @ File descriptor (stdout)
    ldr r1, =message        @ Load address of the message
    mov r2, #16             @ Message length
    mov r7, #4              @ sys_write
    svc #0                  @ Call kernel

    mov r7, #1              @ sys_exit
    mov r0, #0              @ Exit status 0
    svc #0                  @ Call kernel

.section .data
message:
    .asciz "Hello, ARM World!\n"

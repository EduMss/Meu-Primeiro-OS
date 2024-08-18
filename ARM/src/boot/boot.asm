.section .text
.global _start

_start:
    ; Inicializar o sistema (Apenas exemplo, pode variar)
    mov r0, #1          ; Número do file descriptor (1 para stdout)
    ldr r1, =message    ; Endereço da mensagem
    mov r2, #13         ; Tamanho da mensagem
    mov r7, #4          ; Número da syscall para sys_write
    svc #0             ; Chamar o kernel

    ; Finalizar o processo
    mov r7, #1          ; Número da syscall para exit
    mov r0, #0          ; Código de saída 0
    svc #0             ; Chamar o kernel

.section .data
message:
    .asciz "Hello, ARM World!\n"
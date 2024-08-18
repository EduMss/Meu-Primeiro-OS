.global _start

_start:
    ; Definir a string a ser impressa
    .data
    msg: .asciz "Hello, world!\n"

    ; Código principal
    .text
    ldr r0, =1           ; File descriptor para stdout (1)
    ldr r1, =msg         ; Endereço da string
    ldr r2, =14          ; Número de caracteres a serem escritos

    ; Chamada do sistema write
    mov r7, #4           ; Número da chamada de sistema (write)
    svc 0               ; Executar a chamada de sistema

    ; Encerrar o programa
    mov r7, #1           ; Número da chamada de sistema (exit)
    mov r0, #0           ; Código de retorno
    svc 0

.end
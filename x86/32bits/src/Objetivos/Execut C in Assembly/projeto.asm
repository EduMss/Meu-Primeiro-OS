section .data
    buffer db "Resultado: ", 10 dup('0'), 0 ; Buffer para armazenar o número em ASCII
    newline dd 10                     ; Nova linha (opcional)

section .text
    global _start
    extern soma                             ; Declaração da função soma (em C)

_start:
    ; Configurar os argumentos da função
    push dword 7                            ; Segundo argumento
    push dword 3                            ; Primeiro argumento
    call soma                               ; Chamar a função soma
    add esp, 8                              ; Limpar os argumentos da pilha

    ; Nova linha (opcional)
    mov eax, 4                              ; syscall: sys_write
    mov ebx, 1
    mov ecx, newline
    mov edx, 10
    int 0x80

    ; Sair do programa
    mov eax, 1                              ; syscall: sys_exit
    xor ebx, ebx                            ; Código de saída: 0
    int 0x80

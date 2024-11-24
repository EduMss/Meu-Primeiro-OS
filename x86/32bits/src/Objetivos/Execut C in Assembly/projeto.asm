section .data
    resultado dd 0           ; Armazena o resultado retornado pela função

section .text
    global _start            ; Ponto de entrada
    extern soma              ; Referência externa à função C

_start:
    ; Configurar os argumentos (convenção cdecl)
    push dword 7             ; Segundo argumento: 7
    push dword 4             ; Primeiro argumento: 3
    call soma                ; Chamar a função "soma"
    add esp, 8               ; Limpar os argumentos da pilha

    ; Armazenar o resultado
    mov [resultado], eax     ; O retorno da função soma está em EAX

    ; Dividir o resultado por 10
    mov eax, [resultado]     ; Número a ser dividido
    xor edx, edx             ; Limpar EDX
    mov ecx, 10              ; Divisor
    div ecx                  ; EAX contém o quociente, EDX contém o resto

    ; Printar o resultado (no caso, o quociente)
    mov eax, 4               ; Syscall para escrever
    mov ebx, 1               ; Saída padrão (stdout)
    mov edx, 10              ; Tamanho da mensagem (precisa ser ajustado)
    int 0x80                 ; Chamada ao kernel

    ; Sair do programa
    mov eax, 1               ; Syscall: sys_exit
    xor ebx, ebx             ; Código de saída 0
    int 0x80

section .note.GNU-stack noalloc noexec nowrite progbits

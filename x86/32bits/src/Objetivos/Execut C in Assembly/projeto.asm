section .data
    resultado dd 0           ; Armazena o resultado retornado pela função
    printText db "12345678901234567890", 0

section .text
    global _start            ; Ponto de entrada
    extern soma              ; Referência externa à função C
    extern print             ; Referência externa à função C
    ;extern printcpp             ; Referência externa à função CPP

_start:
    ; Configurar os argumentos (convenção cdecl)
    push dword 7             ; Segundo argumento: 7
    push dword 3             ; Primeiro argumento: 3
    call soma                ; Chamar a função "soma" C
    add esp, 8               ; Limpar os argumentos da pilha

    call print               ; Chamar a função "print" C
    ;call printcpp            ; Chamar a função "printcpp" C++

    ; Armazenar o resultado
    mov [resultado], eax     ; O retorno da função soma está em EAX

    ; Dividir o resultado por 10
    ;mov eax, [resultado]     ; Número a ser dividido
    xor edx, edx             ; Limpar EDX
    mov ecx, 10              ; Divisor
    div ecx                  ; EAX contém o quociente, EDX contém o resto

    ; Printar o resultado (no caso, o quociente)
    ;mov edx, ecx             ; Tamanho da mensagem (vai seo o tamanho do resultado)
    ;mov eax, 4               ; Syscall para escrever
    ;mov ebx, 1               ; Saída padrão (stdout)
    ;mov ecx, printText       ;   
    ;int 0x80                 ; Chamada ao kernel

    ; Printar o resultado (no caso, o quociente)
    ;mov edx, ecx             ; Tamanho da mensagem (vai seo o tamanho do resultado)
    mov eax, 4               ; Syscall para escrever
    mov ebx, 1               ; Saída padrão (stdout)
    ;mov ecx, printText       ;   
    mov edx, 10              ; Tamanho da mensagem (precisa ser ajustado)
    int 0x80                 ; Chamada ao kernel

    ; Sair do programa
    mov eax, 1               ; Syscall: sys_exit
    xor ebx, ebx             ; Código de saída 0
    int 0x80

section .note.GNU-stack noalloc noexec nowrite progbits

section .data


section .text
    global _start            ; Ponto de entrada
    extern texto              ; Referência externa à função C
    ;extern printcpp             ; Referência externa à função CPP

_start:
    ; Configurar os argumentos (convenção cdecl)
    call texto               ; Chamar a função "print" C
    add esp, 8               ; Limpar os argumentos da pilha


    mov ecx, eax

    ; Printar o resultado (no caso, o quociente)
    mov edx, 10             ; Tamanho da mensagem (vai seo o tamanho do resultado)
    mov eax, 4               ; Syscall para escrever
    mov ebx, 1               ; Saída padrão (stdout)
    int 0x80                 ; Chamada ao kernel

    ; Sair do programa
    mov eax, 1               ; Syscall: sys_exit
    xor ebx, ebx             ; Código de saída 0
    int 0x80

section .note.GNU-stack noalloc noexec nowrite progbits
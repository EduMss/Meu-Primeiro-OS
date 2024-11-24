section .data
    resultado dd 0           ; Armazena o resultado retornado pela função

section .text
    global _start            ; Ponto de entrada
    extern soma              ; Referência externa à função C

_start:
    ; Configurar os argumentos (convenção cdecl)
    push dword 7             ; Segundo argumento: 7
    push dword 3             ; Primeiro argumento: 3
    call soma                ; Chamar a função "soma"
    add esp, 8               ; Limpar os argumentos da pilha

    ; Armazenar o resultado
    mov [resultado], eax     ; O retorno está em EAX

    ; printar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, [resultado]     ; ponteiro para a mensagem
    mov edx, 10              ; comprimento da mensagem
    int 0x80                 ; chamada ao kernel

    ; Sair do programa
    mov eax, 1               ; syscall: sys_exit
    xor ebx, ebx             ; Código de saída 0
    int 0x80

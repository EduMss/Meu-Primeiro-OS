section .data
    buffer db "Resultado: ", 10 dup('0'), 0 ; Buffer para armazenar o número em ASCII
    newline db 0xA, 0                       ; Nova linha (opcional)

section .text
    global _start
    extern soma                             ; Declaração da função soma (em C)

_start:
    ; Configurar os argumentos da função
    push dword 7                            ; Segundo argumento
    push dword 3                            ; Primeiro argumento
    call soma                               ; Chamar a função soma
    add esp, 8                              ; Limpar os argumentos da pilha

    ; O valor retornado pela soma está em EAX
    mov ecx, 10                             ; Base decimal
    mov edi, buffer + 10                    ; Fim do espaço reservado para o número
    mov byte [edi], 0                       ; Null terminator para string

convert_to_ascii:
    xor edx, edx                            ; Limpar edx
    div ecx                                 ; Dividir EAX por 10 (ECX)
    add dl, '0'                             ; Converter o resto (EDX) para ASCII
    dec edi                                 ; Andar para trás no buffer
    mov [edi], dl                           ; Armazenar o dígito
    test eax, eax                           ; Verificar se ainda restam dígitos
    jnz convert_to_ascii                    ; Repetir enquanto EAX não for 0

    ; Escrever a mensagem e o número no terminal
    mov eax, 4                              ; syscall: sys_write
    mov ebx, 1                              ; File descriptor: stdout
    mov ecx, buffer                         ; Ponteiro para o buffer
    mov edx, buffer + 10 - edi + 12         ; Comprimento da string
    int 0x80

    ; Nova linha (opcional)
    mov eax, 4                              ; syscall: sys_write
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Sair do programa
    mov eax, 1                              ; syscall: sys_exit
    xor ebx, ebx                            ; Código de saída: 0
    int 0x80

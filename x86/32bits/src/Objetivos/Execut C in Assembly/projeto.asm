section .data
    resultado db "Resultado: ", 0   ; Prefixo da mensagem
    buffer db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; Buffer para o número convertido em string
    newline db 10, 0                ; Nova linha

section .bss
    len resb 1                      ; Comprimento da string gerada

section .text
    global _start                   ; Ponto de entrada
    extern soma                     ; Declaração da função C

_start:
    ; Chamar a função soma(7, 3)
    push dword 7                    ; Segundo argumento
    push dword 3                    ; Primeiro argumento
    call soma                       ; Chamar a função
    add esp, 8                      ; Limpar a pilha

    ; Converter o resultado (EAX) em string
    mov ecx, buffer                 ; Ponteiro para o buffer
    mov ebx, eax                    ; Número a ser convertido
    call int_to_string              ; Chama a rotina de conversão

    ; Imprimir "Resultado: "
    mov eax, 4                      ; syscall: sys_write
    mov ebx, 1                      ; stdout
    mov ecx, resultado              ; Ponteiro para a mensagem
    mov edx, 11                     ; Comprimento da mensagem
    int 0x80                        ; Chamada ao kernel

    ; Imprimir o número convertido
    mov eax, 4                      ; syscall: sys_write
    mov ebx, 1                      ; stdout
    mov ecx, buffer                 ; Ponteiro para o buffer
    mov edx, [len]                  ; Comprimento do número
    int 0x80                        ; Chamada ao kernel

    ; Imprimir uma nova linha
    mov eax, 4                      ; syscall: sys_write
    mov ebx, 1                      ; stdout
    mov ecx, newline                ; Ponteiro para a nova linha
    mov edx, 1                      ; Comprimento da nova linha
    int 0x80                        ; Chamada ao kernel

    ; Sair do programa
    mov eax, 1                      ; syscall: sys_exit
    xor ebx, ebx                    ; Código de saída 0
    int 0x80

; Rotina para converter um número inteiro para string (base 10)
int_to_string:
    xor edx, edx                    ; Limpar EDX (resto)
    mov esi, 10                     ; Divisor (base 10)
    mov edi, ecx                    ; Armazena o ponteiro original

convert_loop:
    xor edx, edx                    ; Limpar EDX
    div esi                         ; EAX / 10, resto em EDX
    add dl, '0'                     ; Converter dígito para ASCII
    dec ecx                         ; Move o ponteiro para trás
    mov [ecx], dl                   ; Armazena o caractere
    test eax, eax                   ; Verifica se o quociente é 0
    jnz convert_loop                ; Se não, continua

    mov eax, edi                    ; Ponteiro original do buffer
    sub eax, ecx                    ; Calcula o comprimento
    mov [len], al                   ; Salva o comprimento
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
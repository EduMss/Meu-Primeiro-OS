section .data
    msg db 'A soma é: ', 0xA  ; Mensagem a ser impressa
    num db 10 dup(0)        ; Buffer para armazenar a string do número

section .text
    global _start
    extern soma 

_start:
    ; Chamar a função soma(7, 3)
    push dword 7                    ; Segundo argumento
    push dword 3                    ; Primeiro argumento
    call soma                       ; Chamar a função
    add esp, 8                      ; Limpar a pilha
    ; resultado em eax

    ; Inicializar o buffer com zeros
    mov ecx, 10
    mov esi, num
.init_loop:
    mov byte [esi], '0'
    inc esi
    loop .init_loop

    ; Converter inteiro para string
    mov ecx, 10
    mov esi, num + 9 ; Começar do final do buffer
    mov edx, eax

.convert_loop:
    xor edx, edx  ; Clear EDX for division
    div ecx       ; Divide by 10
    add dl, '0'   ; Convert remainder to ASCII digit
    dec esi       ; Move to the next position in the buffer
    mov [esi], dl
    cmp eax, 0    ; Check if the quotient is zero
    jne .convert_loop

    ; Adicionando um caractere nulo para marcar o final da string
    mov byte [esi], 0

    ; Imprimir a mensagem e o número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, num
    int 0x80

    ; Encerrar o programa
    mov eax, 1
    mov ebx, 0
    int 0x80

section .note.GNU-stack noalloc noexec nowrite progbits
section .data
    number dd 10             ; O valor a ser impresso
    buffer db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ; Buffer para armazenar a string do número
    buffer_len equ 11        ; Tamanho do buffer
    newline db 10, 0         ; Nova linha (opcional)

section .bss

section .text
    global _start

_start:
    ; Carregar o valor de 'number' para EAX
    mov eax, [number]

    ; Converter para string
    mov edi, buffer          ; Apontar para o buffer
    call int_to_string       ; Chama a função para converter EAX para string

    ; Escrever o número no terminal
    mov eax, 4               ; syscall: sys_write
    mov ebx, 1               ; arquivo: saída padrão
    mov ecx, edi             ; ponteiro para a string (buffer)
    sub edi, buffer          ; Calcula o tamanho da string gerada
    mov edx, edi             ; comprimento da string
    add edi, buffer          ; Restaura o ponteiro do buffer
    int 0x80                 ; chamada ao kernel

    ; Escrever uma nova linha
    mov eax, 4               ; syscall: sys_write
    mov ebx, 1               ; arquivo: saída padrão
    mov ecx, newline         ; ponteiro para a nova linha
    mov edx, 1               ; comprimento da nova linha
    int 0x80                 ; chamada ao kernel

    ; Encerrar o programa
    mov eax, 1               ; syscall: sys_exit
    xor ebx, ebx             ; Código de saída: 0
    int 0x80                 ; chamada ao kernel

; Função para converter EAX (inteiro) para uma string decimal
; Entrada: EAX contém o número
; Saída: Buffer contém a string do número, apontado por EDI
int_to_string:
    xor ecx, ecx             ; ECX será usado para contar os dígitos
.next_digit:
    xor edx, edx             ; Limpar EDX antes de DIV
    mov ebx, 10              ; Divisor
    div ebx                  ; EAX = EAX / 10, EDX = resto
    add dl, '0'              ; Converte o dígito para ASCII
    dec edi                  ; Move para trás no buffer
    mov [edi], dl            ; Armazena o dígito no buffer
    inc ecx                  ; Incrementa o contador de dígitos
    test eax, eax            ; Verifica se ainda há mais dígitos
    jnz .next_digit          ; Continua se EAX > 0

    ; Aponta EDI para o início da string gerada
    add edi, buffer_len      ; EDI aponta para o final do buffer
    sub edi, ecx             ; Ajusta EDI para o início do número
    ret

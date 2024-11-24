section .data
    resultado dd 0           ; Armazena o resultado retornado pela função
    buffer db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ; Buffer para armazenar o número convertido
    len dd 0                 ; Comprimento da string resultante

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

    ; Converter o número para string
    mov eax, [resultado]     ; Número para converter
    mov ebx, buffer          ; Ponteiro para o buffer
    call int_to_str          ; Chamar a função de conversão
    mov [len], ecx           ; Armazena o comprimento da string

    ; Imprimir o resultado
    mov eax, 4               ; syscall: sys_write
    mov ebx, 1               ; file descriptor: saída padrão
    mov ecx, buffer          ; Ponteiro para a string
    mov edx, [len]           ; Comprimento da string
    int 0x80                 ; chamada ao kernel

    ; Sair do programa
    mov eax, 1               ; syscall: sys_exit
    xor ebx, ebx             ; Código de saída 0
    int 0x80

; Função para converter um número em uma string
int_to_str:
    xor ecx, ecx             ; Limpar o contador (comprimento)
    mov edx, 0               ; Limpar o resto

.int_to_str_loop:
    mov eax, [resultado]     ; Número a ser dividido (dividendo)
    xor edx, edx             ; Limpar o resto
    ;div dword 10             ; EAX = EAX / 10, EDX = resto
    mov ecx, 10              ; Divisor
    div ecx                  ; Dividir EDX:EAX por ECX (quociente em EAX, resto em EDX)
    add dl, '0'              ; Converter dígito para ASCII
    dec ebx                  ; Avançar no buffer para trás
    mov [ebx], dl            ; Armazenar o dígito no buffer
    inc ecx                  ; Incrementar o comprimento
    test eax, eax            ; Verificar se EAX é 0
    jnz .int_to_str_loop     ; Repetir se não for 0

    mov eax, ebx             ; Retornar o endereço da string no EAX
    ret

; Adicione a diretiva .note.GNU-stack ao final do arquivo Assembly para indicar que a pilha não é executável
section .note.GNU-stack noalloc noexec nowrite progbits 
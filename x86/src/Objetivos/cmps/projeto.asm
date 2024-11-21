section .data
    inicial_msg db "Digite um texto de ate 63 caracteres que eu irei verificar se tem a letra 'r'", 0xA
    inicial_msg_len equ $ - inicial_msg
    index_r dd 0

    true_msg db "Tem 'r' no texto"
    true_msg_len equ $ - true_msg
    false_msg db "Não tem 'r' no texto"
    false_msg_len equ $ - false_msg

section .bss
    texto_buffer resb 64

section .text
    global _start

_start:
    mov eax, 4 
    mov ebx, 1
    mov ecx, inicial_msg
    mov edx, inicial_msg_len
    int 0x80

usuario_input:
    mov eax, 3
    mov ebx, 0
    mov ecx, texto_buffer
    mov edx, 64
    int 0x80

    mov esi, texto_buffer

verificar:
    cmp byte [esi], 0x72 ; em hexadecimal 0x72 e 'r'
    je imprimir_true ; se tiver r, vai executar o "imprimir_true"
    inc esi ; avançar para o proximo caractere do esi
    cmp byte [esi], 0 ; verificar se não chegamos no final do texto
    je imprimir_false ; se for 0, vai executar o "imprimir_false"
    jmp verificar

; cmp => je (se for verdadeiro) | jne (se for falso)

imprimir_true:
    mov eax, 4 
    mov ebx, 1
    mov ecx, true_msg
    mov edx, true_msg_len
    int 0x80

    mov eax, 4 
    mov ebx, 1
    mov ecx, esi
    mov edx, 64
    int 0x80

    ; Finaliza o programa
    mov eax, 1           ; syscall: sys_exit
    xor ebx, ebx         ; código de saída 0
    int 0x80             ; chamada ao kernel


imprimir_false:
    mov eax, 4 
    mov ebx, 1
    mov ecx, false_msg
    mov edx, false_msg_len
    int 0x80

    ; Finaliza o programa
    mov eax, 1           ; syscall: sys_exit
    xor ebx, ebx         ; código de saída 0
    int 0x80             ; chamada ao kernel

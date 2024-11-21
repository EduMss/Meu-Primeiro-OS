section .data
    inicial_msg db "Digite um texto de ate 63 caracteres que eu irei verificar se tem a letra 'r'", 0xA
    inicial_msg_len equ $ - inicial_msg
    index_r dd 0

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

imprimir_input:
    mov eax, 4 
    mov ebx, 1
    mov ecx, texto_buffer
    mov edx, 64
    int 0x80


finalizar: 
    ; Finaliza o programa
    mov eax, 1           ; syscall: sys_exit
    xor ebx, ebx         ; código de saída 0
    int 0x80             ; chamada ao kernel
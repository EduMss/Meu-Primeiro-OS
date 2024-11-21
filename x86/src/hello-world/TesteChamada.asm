section .data
    msg db "Hello, World!", 0xA  ; Mensagem a ser exibida, seguida de uma nova linha
    len equ $ - msg              ; Comprimento da mensagem

section .text
    global _start                ; Ponto de entrada

_start:
    mov eax, 4                   ; syscall: sys_write
    mov ebx, 1                   ; file descriptor: stdout
    mov ecx, msg                 ; ponteiro para a mensagem
    mov edx, len                 ; comprimento da mensagem
    int 0x80                     ; chamada ao kernel

    mov eax, 1                   ; syscall: sys_exit
    xor ebx, ebx                 ; código de saída: 0
    int 0x80                     ; chamada ao kernel

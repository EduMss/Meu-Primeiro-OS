section .data
    hello_msg db "Olá ", 0       ; Prefixo da mensagem
    welcome_msg db ", Seja Bem-vindo!", 0xA, 0 ; Sufixo da mensagem com nova linha
    Fist_msg db "Informe seu nome: ", 0;0xA    ; Mensagem peguntando o nome
    len equ $ - Fist_msg              ; Comprimento da mensagem

section .bss
    name_buffer resb 32          ; Buffer para armazenar o nome do usuário (máx 31 chars + null)
    

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, Fist_msg            ; ponteiro para a mensagem
    mov edx, len                 ; comprimento da mensagem
    int 0x80                     ; chamada ao kernel

nome_usuario:
    mov eax, 3  ; ler terminal
    mov ebx, 0  ; sdtin
    mov ecx, my_string   ; endereço de memória para armazenar a entrada
    mov edx, 64          ; número máximo de bytes a ler (tamanho do buffer)
    int 0x80             ; chamada ao kernel

    ; Exibindo o nome do usuário (usando sys_write)
    mov eax, 4           ; syscall: sys_write
    mov ebx, 1           ; file descriptor: stdout (saída padrão)
    mov edx, 64          ; número máximo de bytes a escrever
    int 0x80             ; chamada ao kernel

finalizar: 
    ; Finaliza o programa
    mov eax, 1           ; syscall: sys_exit
    xor ebx, ebx         ; código de saída 0
    int 0x80             ; chamada ao kernel
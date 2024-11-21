section .data
    hello_msg db "Olá ", 0       ; Prefixo da mensagem
    welcome_msg db ", Seja Bem-vindo!", 0xA, 0 ; Sufixo da mensagem com nova linha
    name_buffer resb 32          ; Buffer para armazenar o nome do usuário (máx 31 chars + null)

section .text
    global _start

_start:
    ; 1. Obter o nome do usuário
    mov eax, 3               ; syscall: sys_read
    mov ebx, 0               ; file descriptor: stdin
    mov ecx, name_buffer     ; Buffer onde o nome será armazenado
    mov edx, 32              ; Tamanho máximo da entrada
    int 0x80                 ; Chamada ao kernel

    ; 2. Remover a nova linha digitada pelo usuário
    mov esi, name_buffer     ; Ponteiro para o início do buffer
remove_newline:
    cmp byte [esi], 0xA      ; Verifica se é '\n' (nova linha)
    je add_null              ; Se for, substitui por 0 (null terminator)
    cmp byte [esi], 0        ; Verifica se é o fim do texto (0)
    je add_null              ; Se for, pula para o fim
    inc esi                  ; Avança para o próximo caractere
    jmp remove_newline       ; Continua verificando
add_null:
    mov byte [esi], 0        ; Adiciona o terminador null

    ; 2.1 Calcular o comprimento do nome
    sub esi, name_buffer     ; Comprimento da string = posição atual - início
    mov edx, esi             ; Salva o comprimento em edx

    ; 3. Concatenar as strings e exibir
    ; Escreve a mensagem "Olá "
    mov eax, 4               ; syscall: sys_write
    mov ebx, 1               ; file descriptor: stdout
    mov ecx, hello_msg       ; Endereço da string "Olá "
    mov edx, 5               ; Tamanho da string
    int 0x80                 ; Chamada ao kernel

    ; Escreve o nome do usuário
    mov eax, 4               ; syscall: sys_write
    mov ebx, 1               ; file descriptor: stdout
    mov ecx, name_buffer     ; Endereço do buffer com o nome
    ; edx já contém o comprimento do nome
    int 0x80                 ; Chamada ao kernel

    ; Escreve a mensagem ", Seja Bem-vindo!"
    mov eax, 4               ; syscall: sys_write
    mov ebx, 1               ; file descriptor: stdout
    mov ecx, welcome_msg     ; Endereço da string final
    mov edx, 20              ; Tamanho da string ", Seja Bem-vindo!"
    int 0x80                 ; Chamada ao kernel

    ; 4. Encerrar o programa
    mov eax, 1               ; syscall: sys_exit
    xor ebx, ebx             ; Código de saída: 0
    int 0x80                 ; Chamada ao kernel

; section .data
;     hello_msg db "Olá ", 0       ; Prefixo da mensagem
;     welcome_msg db ", Seja Bem-vindo!", 0xA, 0 ; Sufixo da mensagem com nova linha
;     Fist_msg db "Informe seu nome: ", 0;0xA    ; Mensagem peguntando o nome
;     len equ $ - Fist_msg              ; Comprimento da mensagem

section .data
    prompt db "Digite seu nome: ", 0
    msg db "Olá, ", 0

section .bss
    name_buffer resb 32          ; Buffer para armazenar o nome do usuário (máx 31 chars + null)
    

section .text
    global _start

_start:
;     mov eax, 4
;     mov ebx, 1
;     mov ecx, Fist_msg            ; ponteiro para a mensagem
;     mov edx, len                 ; comprimento da mensagem
;     int 0x80                     ; chamada ao kernel

; nome_usuario:
    ; Exibe a mensagem pedindo o nome
    mov eax, 4            ; syscall: sys_write
    mov ebx, 1            ; file descriptor: stdout
    mov ecx, prompt       ; ponteiro para a mensagem
    mov edx, 18           ; comprimento da mensagem
    int 0x80              ; chamada ao kernel

    ; Lê o nome do usuário
    mov eax, 3            ; syscall: sys_read
    mov ebx, 0            ; file descriptor: stdin
    mov ecx, name_buffer  ; ponteiro para o buffer
    mov edx, 32           ; número máximo de bytes a ler
    int 0x80              ; chamada ao kernel

    ; Remove a nova linha do final (se houver)
    mov esi, name_buffer  ; ponteiro para o buffer
remove_newline:
    cmp byte [esi], 0xA   ; verifica se é nova linha
    je add_null           ; se for, substitui por 0 (null terminator)
    cmp byte [esi], 0     ; verifica se chegou ao fim da string
    je add_null           ; se for 0 (null), terminou
    inc esi               ; avança para o próximo caractere
    jmp remove_newline    ; continua verificando

add_null:
    mov byte [esi], 0     ; substitui nova linha por terminador nulo

    ; Concatena a string "Olá " ao nome digitado
    mov esi, msg          ; ponteiro para "Olá "
    mov edi, name_buffer  ; ponteiro para o nome do usuário
    call concat_strings   ; chama a função para concatenar

    ; Exibe a mensagem final com o nome
    mov eax, 4            ; syscall: sys_write
    mov ebx, 1            ; file descriptor: stdout
    mov ecx, name_buffer  ; ponteiro para a mensagem
    mov edx, 32           ; tamanho máximo da mensagem
    int 0x80              ; chamada ao kernel

    ; Finaliza o programa
    mov eax, 1            ; syscall: sys_exit
    xor ebx, ebx          ; código de saída: 0
    int 0x80              ; chamada ao kernel

; Função para concatenar "Olá " com o nome do usuário
concat_strings:
    ; Copia "Olá " para name_buffer
    push esi
    push edi
    mov esi, msg          ; ponteiro para "Olá "
    mov edi, name_buffer  ; ponteiro para o nome do usuário
copy_msg:
    mov al, [esi]         ; carrega o próximo byte de "Olá "
    mov [edi], al         ; coloca no buffer do nome
    inc esi
    inc edi
    cmp al, 0             ; verifica se chegou ao fim de "Olá "
    je done_copy
    jmp copy_msg

done_copy:
    pop edi
    pop esi
    ret
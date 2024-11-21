section .data
    file_buffer dd 0
    nova_msg db "Novo Mundo!", 0xA
    nova_msg_len equ $ - nova_msg
    filename db "example.txt", 0 

section .bss
    buffer resb 100                ; Buffer para armazenar a leitura (100 bytes)
    ;filename resb 100
    
section .text
    global _start

_start:
    ; Abrir o arquivo para leitura
    mov eax, 5          ; syscall: sys_open
    mov ebx, filename   ; nome do arquivo
    mov ecx, 2       ; O_FLAGS: O_WRONLY (2) | Leitura e escrita, O_CREAT (0x40) | criar o arquivos se não existir
    int 0x80            ; chamada ao kernel
    mov ebx, eax        ; O descritor do arquivo retornado é colocado em ebx

    ; Verificar se houve erro na abertura do arquivo (se o arquivo não foi aberto corretamente)
    test eax, eax                 ; Se eax for negativo, ocorreu um erro
    js .exit                      ; Se erro, sair

    ; Finalizar o programa
    mov eax, 1                    ; syscall número 1 para exit
    xor ebx, ebx                  ; código de saída (0)
    int 0x80                      ; chamada ao kernel

.exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, nova_msg            ; ponteiro para a mensagem
    mov edx, nova_msg_len                 ; comprimento da mensagem
    int 0x80                     ; chamada ao kernel

    ; Finalizar o programa
    mov eax, 1                    ; syscall número 1 para exit
    xor ebx, ebx                  ; código de saída (0)
    int 0x80                      ; chamada ao kernel
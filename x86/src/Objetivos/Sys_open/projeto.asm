section .data
    filename db "example.txt", 0  ; Nome do arquivo (se tiver so o nome, ele procurara no diretorio onde o programa esta sendo executado, se eu quiser buscar em outro diretorio basta colocar o caminho completo "/home/example.txt")
    nova_msg db "Novo Mundo!", 0xA
    nova_msg_len equ $ - nova_msg

section .bss
    buffer resb 100                ; Buffer para armazenar a leitura (100 bytes)
    file_buffer dd 0

section .text
    global _start

_start:

    ; Abrir o arquivo para leitura
    mov eax, 5          ; syscall: sys_open
    mov ebx, filename   ; nome do arquivo
    mov ecx, 0x402       ; O_FLAGS: O_WRONLY (2) | Leitura e escrita, O_CREAT (0x40) | criar o arquivos se não existir
    int 0x80            ; chamada ao kernel
    mov ebx, eax        ; O descritor do arquivo retornado é colocado em ebx

    ; Verificar se houve erro na abertura do arquivo (se o arquivo não foi aberto corretamente)
    test eax, eax                 ; Se eax for negativo, ocorreu um erro
    js .exit                      ; Se erro, sair

    mov file_buffer, eax
    ; Ler do arquivo
    mov eax, 3          ; syscall: sys_read
    mov ecx, buffer     ; ponteiro para o buffer de leitura
    mov edx, 100        ; quantidade máxima de bytes para ler
    int 0x80            ; chamada ao kernel

    ; printar oque esta escrito
    mov eax, 4
    mov ebx, 1
    int 0x80

    ; Escrever no arquivo
    mov ebx, [file_buffer]                  ; file descriptor retornado pela syscall open
    mov eax, 4                    ; syscall número 4 para write
    mov ecx, nova_msg                  ; mensagem para ser escrita
    mov edx, nova_msg_len                   ; comprimento da mensagem (13 bytes)
    int 0x80                      ; chamada ao kernel


    ; Fechar o arquivo
    mov eax, 6          ; syscall: sys_close
    int 0x80            ; chamada ao kernel

.exit:
    ; Finalizar o programa
    mov eax, 1                    ; syscall número 1 para exit
    xor ebx, ebx                  ; código de saída (0)
    int 0x80                      ; chamada ao kernel
section .data
    filename db "example.txt", 0  ; Nome do arquivo (se tiver so o nome, ele procurara no diretorio onde o programa esta sendo executado, se eu quiser buscar em outro diretorio basta colocar o caminho completo "/home/example.txt")
    buffer resb 100                ; Buffer para armazenar a leitura (100 bytes)

section .text
    global _start

_start:
    ; Abrir o arquivo para leitura
    mov eax, 5          ; syscall: sys_open
    mov ebx, filename   ; nome do arquivo
    mov ecx, 0x402       ; O_FLAGS: O_WRONLY (2) | Leitura e escrita, O_CREAT (0x40) | criar o arquivos se não existir
    int 0x80            ; chamada ao kernel
    mov ebx, eax        ; O descritor do arquivo retornado é colocado em ebx

    ; Ler do arquivo
    mov eax, 3          ; syscall: sys_read
    mov ecx, buffer     ; ponteiro para o buffer de leitura
    mov edx, 100        ; quantidade máxima de bytes para ler
    int 0x80            ; chamada ao kernel

    ; Fechar o arquivo
    mov eax, 6          ; syscall: sys_close
    int 0x80            ; chamada ao kernel

    ; Sair
    mov eax, 1          ; syscall: sys_exit
    xor ebx, ebx        ; código de saída 0
    int 0x80            ; chamada ao kernel
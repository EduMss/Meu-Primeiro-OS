section .data
    filename db "large_file.txt", 0

section .text
    global _start

_start:
    ; Abrir o arquivo com O_RDONLY
    mov rax, 2               ; syscall number (2 = open)
    mov rdi, filename        ; endereço do nome do arquivo
    mov rsi, 0               ; O_RDONLY
    syscall                  ; chamada ao kernel

    ; Salvar o descritor de arquivo em rdi
    mov rdi, rax             ; Agora rdi contém o descritor de arquivo

    ; Usar lseek64 para mover o ponteiro do arquivo para um offset grande
    mov rax, 8               ; syscall number (8 = lseek64)
    mov rsi, 0xFFFFFFFF00000000  ; Um grande offset de 64 bits
    mov rdx, SEEK_SET        ; SEEK_SET = 0
    syscall                  ; chamada ao kernel

    ; Continuar com outras operações...
    ; Finalizar o programa
    mov rax, 60              ; syscall number (60 = exit)
    xor rdi, rdi             ; código de saída 0
    syscall                  ; chamada ao kernel

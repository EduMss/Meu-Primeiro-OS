section .bss
    my_string resb 64  ; Reserva 64 bytes de memória para armazenar o nome do usuário

section .text
    global _start

_start:
    ; Lê a entrada do usuário (nome) e armazena em my_string
    mov eax, 3           ; syscall: sys_read
    mov ebx, 0           ; file descriptor: stdin (entrada padrão)
    mov ecx, my_string   ; endereço de memória para armazenar a entrada
    mov edx, 64          ; número máximo de bytes a ler (tamanho do buffer)
    int 0x80             ; chamada ao kernel

    ; Agora, 'my_string' contém o nome digitado pelo usuário
    ; Você pode exibir ou manipular essa string como necessário

    ; Exibindo o nome do usuário (usando sys_write)
    mov eax, 4           ; syscall: sys_write
    mov ebx, 1           ; file descriptor: stdout (saída padrão)
    mov edx, 64          ; número máximo de bytes a escrever
    int 0x80             ; chamada ao kernel

    ; Finaliza o programa
    mov eax, 1           ; syscall: sys_exit
    xor ebx, ebx         ; código de saída 0
    int 0x80             ; chamada ao kernel
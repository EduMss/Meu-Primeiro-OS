section .data
    file_buffer dd 0
    
    finalizando_msg db "\nFinalizando tarefa!", 0xA
    finalizando_msg_len equ $ - finalizando_msg
    
    criado_msg db "ArquivoCriado!", 0xA
    criado_msg_len equ $ - criado_msg

    inicial_msg db "Nome do arquivo desejado: ", 0
    inicial_msg_len equ $ - inicial_msg


section .bss
    buffer resb 100                ; Buffer para armazenar a leitura (100 bytes)
    filename resb 100
    file_conteudo resb 200
    
section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, inicial_msg            ; ponteiro para a mensagem
    mov edx, inicial_msg_len                 ; comprimento da mensagem
    int 0x80                     ; chamada ao kernel

    call .VerificarArquivo


.VerificarArquivo:
    ; Usuario escrevendo nome
    mov eax, 3  ; ler terminal
    mov ebx, 0  ; sdtin
    mov ecx, filename   ; endereço de memória para armazenar a entrada
    mov edx, 100          ; número máximo de bytes a ler (tamanho do buffer)
    int 0x80             ; chamada ao kernel

    mov esi, filename
    call .verificar
    

.verificar:
    cmp byte [esi], 0xA ; em hexadecimal 0xA e '\n'
    je .abrirArquivo; se tiver ele vai remover no "imprimir"
    inc esi ; avançar para o proximo caractere do esi
    cmp byte [esi], 0 ; verificar se não chegamos no final do texto
    je .abrirArquivo; se for 0, vai executar o "imprimir"
    jmp .verificar

.abrirArquivo:
    ; Calcular o comprimento do nome
    sub esi, filename   ; Comprimento da string = posição atual - início

    ; Cortar a string
    mov byte [esi + filename], 0  ; Insere o terminador nulo no final da substring

    ; Abrir o arquivo para leitura
    mov eax, 5          ; syscall: sys_open
    mov ebx, filename   ; nome do arquivo
    mov ecx, 0x402       ; O_FLAGS: O_WRONLY (2) | Leitura e escrita, O_CREAT (0x40) | criar o arquivos se não existir
    int 0x80            ; chamada ao kernel

    mov [file_buffer], eax

    ; Verificar se houve erro na abertura do arquivo (se o arquivo não foi aberto corretamente)
    test eax, eax                 ; Se eax for negativo, ocorreu um erro
    js .criar_arquivo                      ; Se erro, ele vai criar o arquivo, depois vai dar contninuidade no codigo

    call .conteudo


.criar_arquivo:
    ; criando arquivo
    mov eax, 5          ; syscall: sys_open
    mov ebx, filename   ; nome do arquivo
    mov ecx, 0x40       ; O_FLAGS:  O_CREAT (0x40) | criar o arquivos se não existir
    mov edx, 0o777      ; chmod 0777 (octal) - permissões completas (não funciona corretamente, usa o sys_chmod para complementar)
    int 0x80            ; chamada ao kernel

    ; Ajustar permissões manualmente 777
    mov eax, 15         ; syscall: sys_chmod
    mov ebx, filename   ; nome do arquivo
    mov ecx, 0o644      ; permissões exatas desejadas (-rw-r--r--)
    int 0x80            ; chamada ao kernel

    ; printando
    mov eax, 4
    mov ebx, 1
    mov ecx, criado_msg          ; ponteiro para a mensagem
    mov edx, criado_msg_len      ; comprimento da mensagem
    int 0x80                     ; chamada ao kernel

    ; Abrir o arquivo para leitura
    mov eax, 5          ; syscall: sys_open
    mov ebx, filename   ; nome do arquivo
    mov ecx, 0x402        ; O_FLAGS: O_WRONLY (2) | Somente escrita; O_APPEND (0x400) | adicionad
    int 0x80            ; chamada ao kernel

    mov [file_buffer], eax


.conteudo:
    ; Usuario escrevendo conteudo do arquivo:
    mov eax, 3  ; ler terminal
    mov ebx, 0  ; sdtin
    mov ecx, file_conteudo   ; endereço de memória para armazenar a entrada
    mov edx, 200          ; número máximo de bytes a ler (tamanho do buffer)
    int 0x80             ; chamada ao kernel

    ; Escrever no arquivo
    mov eax, 4                    ; syscall número 4 para write
    mov ebx, [file_buffer]        ; file descriptor retornado pela syscall open
    int 0x80                      ; chamada ao kernel

    ; Fechar o arquivo
    mov eax, 6          ; syscall: sys_close
    int 0x80            ; chamada ao kernel

    jmp .continuidade

.continuidade:
    mov eax, 4
    mov ebx, 1
    mov ecx, finalizando_msg            ; ponteiro para a mensagem
    mov edx, finalizando_msg_len                 ; comprimento da mensagem
    int 0x80                     ; chamada ao kernel

    jmp .exit

.exit:
    ; Finalizar o programa
    mov eax, 1                    ; syscall número 1 para exit
    xor ebx, ebx                  ; código de saída (0)
    int 0x80                      ; chamada ao kernel
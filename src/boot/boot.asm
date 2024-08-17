org 0x7c00 ; ta informando que o codigo sera armazenado a partir do endereço de memoria 0x7c00
bits 16 ; ta informando que o codigo sera em 16 bits | para o montador saber que e para montar codigo em 16 bits

;
; BIOS Service - Impressão de caractere como TTY 
; AH    0eH
; AL    character to write
; BL    (graphics modes only) foreground color number
;

main:
    ;
    ; Definir segmentos de dados...
    ;
    mov ax, 0
    mov ds, ax
    mov es, ax
    ;
    ; Iniciar a pilha...
    ;
    mov ss, ax
    mov sp, 0x7c00

; Registrador a -> acumulador de dados
; Registrador b -> base
; Registrador c -> contador (counter)
; Registrador d -> data



print_msg:
    ;
    ; Imprimir mensagem no TTY (com contador)...
    ;
    mov ah, 0x0e
    mov cx, pad - msg
    mov si, msg
.next_char:
    lodsb
    int 0x010
    loop .next_char


;cli     ; Limpa a flag de interrupções

; loop infinito parando a cpu | GAMBIARRA
; mas esse loop so vai acontacer se houver uma interrupção que venha a cancelar o halt
;Jeito 1 para fazer o loop do halt
; halt:
;     ; parada da CPU...
;     hlt 
;     jmp halt 

;Jeito 2 para realizar o loop do halt
halt:
    cli
    hlt

msg: 
    db 'Loading OS...'

pad:
    times 510-($-$$) db 0 ; se o codigo tiver menos que 510 bits, ele vai completar oque falta com 0

sig:
    dw 0xaa55 ; informação padrão para a cpu. TEM QUE TER ESSA INFORMAÇÃO!!!!!
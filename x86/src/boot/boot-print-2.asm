org 0x7c00 ; ta informando que o codigo sera armazenado a partir do endereço de memoria 0x7c00
bits 16 ; ta informando que o codigo sera em 16 bits | para o montador saber que e para montar codigo em 16 bits

;
; BIOS Service - Impressão de caractere como TTY 
; AH    0eH
; AL    character to write
; BL    (graphics modes only) foreground color number
;

main:
    ; Essas definições são uma 'Regrinha' 
    ;
    ; Definir segmentos de dados...
    ;
    ; Os BIOS deverião iniciar todos os segmentos com '0', tanto de codigo quanto de dados, mas nem todas fazem isso 
    mov ax, 0
    mov ds, ax ; Definindo segmentos de dados
    mov es, ax ; Definindo segmentos de dados extra
    ;
    ; Iniciar a pilha...
    ;
    mov ss, ax ; Definindo o registrador do segmento da pilha
    mov sp, 0x7c00 ; iniciando endereço da pilha 
    ; a pilha vai de um endereço alto para mais baixo, então ele vai do endereço 0x7c00 ate o "0" onde esta iniciando o endereço do boot
    ; se for configurado de maneira incorreta, ele pode acabar sobrescrevendo o codigo e dados do boot


    ;Esses registradores(ds, es, ss) não podem receber dados diretamente
    ;Então passa o '0' para o acumulador(ax), e depois a gente passa do acumulador para os registradores

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
org 0x7c00 ; ta informando que o codigo sera armazenado a partir do endereço de memoria 0x7c00
bits 16 ; ta informando que o codigo sera em 16 bits | para o montador saber que e para montar codigo em 16 bits

;
; BIOS Service - Impressão de caractere como TTY 
; AH    0eH
; AL    character to write
; BL    (graphics modes only) foreground color number
;

main:
        ;al -> parte baixa 
        ;ah -> parte alta

        ; [ AH ] [ AL ] AX
        ; Resumindo DECUREBA PURA
        ; mov al, 0x02 ; oque será impresso no terminal, nesse caso e um emoji, tem que ser 1 bit
        ; ;mov al, 'X'
        ; mov ah, 0x0e ; não para que serve, mas tem que ter 
        ; mov bh, 0 ; para informar que a mensagem será mostrada na tela pricipal, nesse caso o terminal 
        ; int 0x10 ; não para que serve, mas tem que ter | hexadecimal: 0x10 ou 10H Coisas que afetam oque aparece na tela

        ; int -> interrupção 
        ; tipos de interrupção:
        ; - interrupção de exeção 
        ; - interrupção de software
        ; - interrupção de hardware

; al e ah so armazenam 1 bit

; 1001 0011
; 1001 0011
;----------------------------------
; 1001 0011 OR - isso e true

; 0000 0000
; 0000 0000
;----------------------------------
; 0000 0000 OR - isso e false

print_str:
    mov si, hello
    mov ah, 0x0e
.next_char: ; sub-rotulo (como se fosse uma função da classe)
    lodsb
    or al, al ; aqui ele esta comparando o al com al, no caso al com ele mesmo | o resultado dessa operação fica armazenado na primeira flag, no caso 'al,' como ele via se manter no mesmo resultado, isso e indiferente
    ;test al, al ;poderia ser dessa maneira tambem no lugar do 'or', pois o 'test' faz um 'AND'
    ; cmp faz uma subtração, mas ela não altera flags
    jz halt ; verifica se essa flag esta ativa para pular ou não, no caso se for 0, não está ativa
    int 0x10 ;vai imprimir
    jmp .next_char


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

;rotulo hello, rotulos representão endereços de codigos
hello: db 'Welcome to LOS/T!', 0 ; esse 0 no final, e para colocar um 0 no final da memoria, para conseguir indenficar que acabou o loop de caracteres

times 510-($-$$) db 0 ; se o codigo tiver menos que 510 bits, ele vai completar oque falta com 0
dw 0xaa55 ; informação padrão para a cpu. TEM QUE TER ESSA INFORMAÇÃO!!!!!
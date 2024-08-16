org 0x7c00 ; ta informando que o codigo sera armazenado a partir do endereço de memoria 0x7c00
bits 16 ; ta informando que o codigo sera em 16 bits

main:

        mov al, 0x02 ; oque será impresso no terminal, nesse caso e um emoji, tem que ser 1 bit
        mov ah, 0x0e ; não para que serve, mas tem que ter
        mov bh, 0 ; para informar que a mensagem será mostrada na tela pricipal, nesse caso o terminal 
        int 0x10 ; não para que serve, mas tem que ter

halt:
    ; parada da CPU...
    hlt 
    jmp halt 

times 510-($-$$) db 0 ; se o codigo tiver menos que 510 bits, ele vai completar oque falta com 0
dw 0xaa55 ; informação padrão para a cpu. TEM QUE TER ESSA INFORMAÇÃO!!!!!
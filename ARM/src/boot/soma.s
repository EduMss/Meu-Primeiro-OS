.section .rodata
fmt: .asciz "A soma é: %d\n"

.text
_start:
    # Carrega os números a serem somados nos registradores
    mov r0, #5
    mov r1, #7

    # Soma os números
    add r2, r0, r1

    # Imprime o resultado
    ldr r0, =fmt
    mov r1, r2
    bl printf

    # Encerra o programa (não é necessário, pois a biblioteca C cuida disso)
    
.global _start

_start:
    # ... (código anterior)

    # Imprime o resultado
    ldr r0, =fmt
    mov r1, r2
    bl _printf

    # ... (código para encerrar)

.section .rodata
fmt: .asciz "A soma é: %d\n"
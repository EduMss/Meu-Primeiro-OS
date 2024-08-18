.global _start

_start:
    # Carrega os números a serem somados nos registradores
    mov r0, #5
    mov r1, #7

    # Soma os números
    add r2, r0, r1

    # Imprime o resultado (essa parte requer uma chamada de sistema específica)
    # ... (código para imprimir o resultado)

    # Encerra o programa
    mov r7, #1
    mov r0, #0
    svc #0
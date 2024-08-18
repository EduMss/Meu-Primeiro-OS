.global _start

_start:
    bl main
    b _start // Loop infinito para manter o programa rodando
```
gcc -m32 -c projeto.c -o projeto.o
```

Se você está compilando para um sistema de 32 bits (ou usando o flag -m32 no GCC), use elf32 para garantir que o arquivo objeto seja de 32 bits.
Se você está compilando para um sistema de 64 bits (ou usando o flag -m64 no GCC), use elf64.

```
nasm -f elf meu_codigo.asm -o meu_codigo_asm.o
```


*elf:*

- É genérico e normalmente mapeado para o formato padrão da arquitetura do sistema operacional.

- Em sistemas de 32 bits, ele gera arquivos no formato ELF de 32 bits.

- Em sistemas de 64 bits, ele gera arquivos no formato ELF de 64 bits.

- O NASM escolhe o formato com base na arquitetura padrão configurada para a compilação.


*elf32:*

- Especifica explicitamente que o arquivo objeto gerado será no formato ELF de 32 bits, independentemente do sistema ou da arquitetura usada.


*elf64:*

- Especifica explicitamente que o arquivo objeto gerado será no formato ELF de 64 bits.


```
file meu_codigo_asm.o
```


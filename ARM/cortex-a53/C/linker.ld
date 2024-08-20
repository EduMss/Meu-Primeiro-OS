ENTRY(main)

SECTIONS
{
    . = 0x10000;

    .text : {
        *(.text)            /* Código executável */
    } > ROM

    .data : {
        *(.data)            /* Dados inicializados */
    } > RAM

    .bss : {
        *(.bss)             /* Dados não inicializados */
    } > RAM

    _end = .;
}

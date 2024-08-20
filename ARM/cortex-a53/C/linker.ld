/* Define as regiões de memória */
MEMORY
{
    ROM (rx) : ORIGIN = 0x10000, LENGTH = 0x10000
    RAM (rwx) : ORIGIN = 0x20000, LENGTH = 0x10000
}

ENTRY(_start)

SECTIONS
{
    /* Seção de texto (código executável) */
    .text : {
        *(.text)
        *(.text.*)
        *(.gnu.warning)
    } > ROM

    /* Seção de dados (dados inicializados) */
    .data : {
        *(.data)
        *(.data.*)
    } > RAM AT> ROM

    /* Seção BSS (dados não inicializados) */
    .bss : {
        *(.bss)
        *(.bss.*)
        *(COMMON)
    } > RAM

    /* Dados de fim */
    _end = .;
}

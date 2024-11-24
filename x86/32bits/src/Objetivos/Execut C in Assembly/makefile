EXECUTABLE_C = projeto.o
SOURCE_C = projeto.c
EXECUTABLE = program
EXECUTABLE_ASM = program_asm.o
SOURCE = projeto.asm

GCC_FLAGS = -m32
ASFLAGS = -f elf32
GCC = gcc
AS = nasm
LD = ld

# Regra padrão para compilar tudo
all: $(EXECUTABLE)

# Compilar o código C em objeto
$(EXECUTABLE_C): $(SOURCE_C)
	$(GCC) $(GCC_FLAGS) -c $(SOURCE_C) -o $(EXECUTABLE_C)

# Compilar o código Assembly em objeto
$(EXECUTABLE_ASM): $(SOURCE)
	$(AS) $(ASFLAGS) $(SOURCE) -o $(EXECUTABLE_ASM)

# Linkar os objetos para criar o executável final
$(EXECUTABLE): $(EXECUTABLE_C) $(EXECUTABLE_ASM)
	$(GCC) $(GCC_FLAGS) $(EXECUTABLE_C) $(EXECUTABLE_ASM) -nostartfiles -o $(EXECUTABLE)

# Regra para limpar os arquivos intermediários
clean:
	rm -f $(EXECUTABLE_ASM) $(EXECUTABLE_C) $(EXECUTABLE)
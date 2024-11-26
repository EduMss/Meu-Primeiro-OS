EXECUTABLE_C = projeto.o
SOURCE_C = projeto.c

EXECUTABLE_CPP = projetocpp.o
SOURCE_CPP = projeto.cpp

EXECUTABLE = program

EXECUTABLE_ASM = program_asm.o
SOURCE_ASM = projeto.asm

GCC_FLAGS = -m32
ASFLAGS = -f elf32
GCC = gcc
AS = nasm
LD = ld
G++ = g++

# Regra padrão para compilar tudo
all: $(EXECUTABLE)

$(EXECUTABLE_CPP): $(SOURCE_CPP)
	$(G++) $(GCC_FLAGS) -c $(SOURCE_CPP) -o $(EXECUTABLE_CPP)

# Compilar o código C em objeto
$(EXECUTABLE_C): $(SOURCE_C)
	$(GCC) $(GCC_FLAGS) -c $(SOURCE_C) -o $(EXECUTABLE_C)

# Compilar o código Assembly em objeto
$(EXECUTABLE_ASM): $(SOURCE_ASM)
	$(AS) $(ASFLAGS) $(SOURCE_ASM) -o $(EXECUTABLE_ASM)

# Linkar os objetos para criar o executável final
#$(EXECUTABLE): $(EXECUTABLE_C) $(EXECUTABLE_ASM) $(EXECUTABLE_CPP)
#	$(GCC) $(GCC_FLAGS) -no-pie $(EXECUTABLE_C) $(EXECUTABLE_CPP) $(EXECUTABLE_ASM) -nostartfiles -o $(EXECUTABLE)

$(EXECUTABLE): $(EXECUTABLE_C) $(EXECUTABLE_ASM)
	$(GCC) $(GCC_FLAGS) -no-pie $(EXECUTABLE_C) $(EXECUTABLE_ASM) -nostartfiles -o $(EXECUTABLE)

# Regra para limpar os arquivos intermediários
c:
	rm -f $(EXECUTABLE_ASM) $(EXECUTABLE_C) $(EXECUTABLE_CPP) $(EXECUTABLE)
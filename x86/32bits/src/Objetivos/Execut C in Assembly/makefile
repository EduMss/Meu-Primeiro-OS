EXECUTABLE_C = projeto.o
SOURCE_C = projeto.c


GCC_FLAGS = -m32

#Compilando codigo C
$(EXECUTABLE_C): $(SOURCE_C)
	gcc $(GCC_FLAGS) -c $(SOURCE_C) -o $(EXECUTABLE_C)


EXECUTABLE = program
EXECUTABLE_ASM = program_asm.o
SOURCE = projeto.asm

AS = nasm
LD = ld

ASFLAGS = -f elf32

#
$(EXECUTABLE): $(SOURCE)
# Compila o Assembly para um arquivo objeto 
	$(AS) $(ASFLAGS) $(SOURCE) -o $(EXECUTABLE_ASM)
#Linke os dois objetos: 
	gcc $(GCC_FLAGS) $(EXECUTABLE_C) $(EXECUTABLE_ASM) -o $(SOURCE)



# Regra para limpar os arquivos intermediários
clean:
	rm -f $(EXECUTABLE_ASM) $(EXECUTABLE) $(EXECUTABLE_C) 

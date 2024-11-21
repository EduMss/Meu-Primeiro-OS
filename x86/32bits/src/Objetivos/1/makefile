EXECUTABLE = program
SOURCE = projeto.asm

AS = nasm
LD = ld

ASFLAGS = -f elf32
LDFLAGS = -m elf_i386

$(EXECUTABLE): $(SOURCE)
# Compila o Assembly para um arquivo objeto
	$(AS) $(ASFLAGS) -o program.o $(SOURCE)  
# Linka o arquivo objeto e gera o executável
	$(LD) $(LDFLAGS) -o $(EXECUTABLE) program.o  

# Regra para limpar os arquivos intermediários
clean:
	rm -f program.o $(EXECUTABLE)

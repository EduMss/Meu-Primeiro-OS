EXECUTABLE = program
SOURCE = TesteChamada.asm

AS = nasm
LD = ld

ASFLAGS = -f elf32


LDFLAGS = -m elf_i386




$(EXECUTABLE): $(SOURCE)
<<<<<<< HEAD
    $(AS) $(ASFLAGS) -o program.o $(SOURCE) 
=======
	$(AS) $(ASFLAGS) -o program.o $(SOURCE)  # Compila o Assembly para um arquivo objeto
	$(LD) $(LDFLAGS) -o $(EXECUTABLE) program.o  # Linka o arquivo objeto e gera o executável

# Regra para limpar os arquivos intermediários
clean:
	rm -f program.o $(EXECUTABLE)
>>>>>>> 7098bfbf8eb1e3c63735860b9b12e4a380033e23

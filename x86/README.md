```
sudo apt -y install nasm

sudo apt install qemu-utils qemu-system-x86 qemu-system-gui

sudo apt install binutils
```

Compile o código Assembly com o NASM:
```
nasm -f elf32 -o hello-world.o hello-world.asm
```

-f elf32: Especifica o formato de saída como ELF de 32 bits.
-o hello-world.o: Especifica o nome do arquivo de saída.


Link o arquivo objeto com o ld:
```
ld -m elf_i386 -o hello-world hello-world.o
```

-m elf_i386: Especifica o formato de 32 bits para linking.
-o hello-world: Especifica o nome do executável de saída.


Execute o programa:
```
./hello-world
```

qemu com o -nographic o resultado "Hello world" aparecera no terminal 

qemu sem o -nographic você precisara mudar a saida de video para serial0, com o qemu aberto vá em "View->serial0" ou "Ctrl+Alt+3"


Usando o aarch64 tambem funciona:
qemu-system-aarch64 -M versatilepb -m 128M -nographic -kernel boot.bin



MSM8916 
cortex-a53


qemu-system-aarch64 -M virt -cpu cortex-a53 -device loader,file=boot.bin,addr=0x10000

qemu-system-aarch64 -M virt -cpu cortex-a53 -kernel boot.elf
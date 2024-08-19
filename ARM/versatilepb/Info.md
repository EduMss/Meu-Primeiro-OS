qemu com o -nographic o resultado "Hello world" aparecera no terminal 

qemu sem o -nographic você precisara mudar a saida de video para serial0, com o qemu aberto vá em "View->serial0" ou "Ctrl+Alt+3"


Usando o aarch64 tambem funciona:
qemu-system-aarch64 -M versatilepb -m 128M -nographic -kernel boot.bin
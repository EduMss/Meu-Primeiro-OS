qemu com o -nographic o resultado "Hello world" aparecera no terminal 

qemu sem o -nographic você precisara mudar a saida de video para serial0, com o qemu aberto vá em "View->serial0" ou "Ctrl+Alt+3"

compilações:
arm-none-eabi-ld -Ttext=0x40000000 | Funcionou
arm-none-eabi-ld -Ttext=0x10000  | Funcionou


Para executar o qemu usando o boot.bin, você precisa compilar usando o "arm-none-eabi-ld -Ttext=0x10000"

Exemplo dos comando:

arm-none-eabi-as -o boot.o boot.s
arm-none-eabi-ld -Ttext=0x10000 -o boot.elf boot.o
arm-none-eabi-objcopy -O binary boot.elf boot.bin
qemu-system-arm -M virt -m 128M -nographic -device loader,file=boot.bin,addr=0x10000

Usando o aarch64 tambem funciona:
qemu-system-aarch64 -M virt -m 128M -nographic -device loader,file=boot.bin,addr=0x10000


Informações do UART0_BASE do virt:
https://github.com/qemu/qemu/blob/master/hw/arm/virt.c
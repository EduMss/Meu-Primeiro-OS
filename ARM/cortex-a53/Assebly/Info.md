qemu com o -nographic o resultado "Hello world" aparecera no terminal 

qemu sem o -nographic você precisara mudar a saida de video para serial0, com o qemu aberto vá em "View->serial0" ou "Ctrl+Alt+3"


Usando o aarch64 tambem funciona:
qemu-system-aarch64 -M versatilepb -m 128M -nographic -kernel boot.bin



MSM8916 
cortex-a53

qemu-system-aarch64 -M virt -cpu cortex-a53 -kernel boot.elf
UART0_BASE, 0x09000000


qemu-system-aarch64 -M virt -cpu cortex-a53 -kernel boot.elf -s -S


NÃO FUNCIONA ::::::

qemu-system-aarch64 -M virt -cpu cortex-a53 -device loader,file=boot.bin,addr=0x10000

qemu-system-aarch64 -M virt -cpu cortex-a53 -device loader,file=boot.bin,addr=0x10000 -s -S



qemu-system-aarch64 -M virt -cpu cortex-a53 -drive file=boot.bin,format=raw,if=none,id=drive0


qemu-img convert -f raw -O qcow2 boot.bin boot.qcow2
qemu-system-aarch64 -M virt -cpu cortex-a53 -drive file=boot.qcow2,format=qcow2



aarch64-linux-gnu-as -o boot.o boot.s \
&& aarch64-linux-gnu-ld -o boot.elf boot.o \
&& aarch64-linux-gnu-objcopy -O binary boot.elf boot.bin

arm-none-eabi-as -o ./src/boot/boot.o ./src/boot/boot.asm \
&& arm-none-eabi-ld -o ./src/boot/boot ./src/boot/boot.o \
&& arm-none-eabi-objcopy -O binary ./src/boot/boot ./src/boot/boot.bin
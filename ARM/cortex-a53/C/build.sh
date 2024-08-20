aarch64-linux-gnu-gcc -nostdlib -nostartfiles -nodefaultlibs -T linker.ld -o boot.elf boot.c \
&& aarch64-linux-gnu-objcopy -O binary boot.elf boot.bin
aarch64-linux-gnu-as -o boot.o boot.s \
&& aarch64-linux-gnu-ld -o boot.elf boot.o \
&& aarch64-linux-gnu-objcopy -O binary boot.elf boot.bin
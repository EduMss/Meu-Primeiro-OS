arm-none-eabi-as -o boot.o boot.s \
&& arm-none-eabi-ld -Ttext=0x40000000 -o boot.elf boot.o \
&& arm-none-eabi-objcopy -O binary boot.elf boot.bin
arm-none-eabi-as -march=armv8-a -o boot.o boot.s \
&& arm-none-eabi-ld -Ttext=0x10000 -o boot.elf boot.o \
&& arm-none-eabi-objcopy -O binary boot.elf boot.bin
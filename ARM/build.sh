arm-none-eabi-as -o ./src/boot/boot.o boot.asm \
&& arm-none-eabi-ld -o ./src/boot/boot boot.o \
&& arm-none-eabi-objcopy -O binary ./src/boot/boot ./src/boot/boot.bin

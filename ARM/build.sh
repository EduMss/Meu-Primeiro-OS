arm-none-eabi-as -o ./src/boot/boot.o ./src/boot/boot.asm \
&& arm-none-eabi-ld -o ./src/boot/boot ./src/boot/boot.o \
&& arm-none-eabi-objcopy -O binary ./src/boot/boot ./src/boot/boot.bin

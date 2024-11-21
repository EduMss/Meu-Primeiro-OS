nasm ./src/boot/boot.asm -f bin -o ./src/boot/build/boot.bin \
&& cp ./src/boot/build/boot.bin ./src/boot/build/boot.img \
&& truncate -s 1440k ./src/boot/build/boot.img

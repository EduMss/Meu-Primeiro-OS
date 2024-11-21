```
sudo apt -y install nasm

sudo apt install qemu-utils qemu-system-x86 qemu-system-gui

sudo apt install binutils
```

Compile o código Assembly com o NASM:
```
nasm -f elf32 -o hello-world.o hello-world.asm
```

-f elf32: Especifica o formato de saída como ELF de 32 bits.
-o hello-world.o: Especifica o nome do arquivo de saída.

<br/>

Link o arquivo objeto com o ld:
```
ld -m elf_i386 -o hello-world hello-world.o
```

-m elf_i386: Especifica o formato de 32 bits para linking.
-o hello-world: Especifica o nome do executável de saída.

<br/>

Execute o programa:
```
./hello-world
```



<h1>Debugar</h1>

Para compilar com o NASM:
```
nasm -f elf32 -g -F dwarf -o hello.o hello.asm
```

-g: Gera informações de depuração.
-F dwarf: Usa o formato de depuração DWARF.

Para ligar com o ld:
```
ld -m elf_i386 -o hello hello.o
```

Inicie o GDB
Execute o GDB com o programa que deseja depurar:
```
gdb ./hello
```


Comandos básicos do GDB

Definir ponto de parada no início do programa:
```
break _start
```

Isso define um ponto de interrupção no rótulo _start (o ponto de entrada do código).

<br/>

Iniciar o programa:
```
run
```

Avançar para a próxima instrução:
```
stepi
```

Esse comando executa a próxima instrução Assembly.

<br/>

Verificar registradores:
```
info registers
```

Mostra o estado atual de todos os registradores.

<br/>

Examinar a memória:

Para ver o conteúdo de um endereço:
```
x/10xb 0xADDR
```

Onde 0xADDR é o endereço de memória, e 10xb significa mostrar 10 bytes em formato hexadecimal.

<br/>

Listar as instruções Assembly:
```
disassemble
```

<br/>

Passos opcionais

Sair do GDB:
```
quit
```

Mais ajuda no GDB:
```
help
```
```
sudo apt -y install nasm

sudo apt install qemu-utils qemu-system-x86 qemu-system-gui

sudo apt install binutils

sudo apt install xxd

sudo apt install hexedit

sudo apt-get -y install libc6-dbg gdb valgrind 
```

Todos de uma vez:
```
sudo apt -y install nasm binutils qemu-utils qemu-system-x86 qemu-system-gui xxd hexedit libc6-dbg gdb valgrind 
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

<br/>

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

<h1>Outros Comandos:</h1>

Obter informações do cabeçalho do arquivo:
```
file hello
```
"hello" e o nome do arquivo

<br/>

Ver o ultimo resultado:
```
echo $?
```
retorna o valor de retorno do que foi executado ou "0" para sucesso

<br/>

Usando o xxd:
```
xxd -c12 -g1 hello
```
-c12 => 12 colunas
-g1 => 1 byte

<br/>

Visualizar tabela ASCII no terminal:
```
man ascii
```
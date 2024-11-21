Sintaxe de sys_open com as flags:
Aqui estão algumas flags que podem ser usadas na syscall sys_open:

O_RDONLY (0): Abrir o arquivo para leitura.
O_WRONLY (1): Abrir o arquivo para escrita.
O_RDWR (2): Abrir o arquivo para leitura e escrita.
O_CREAT (0x40): Criar o arquivo caso ele não exista.
O_TRUNC (0x200): Truncar o arquivo para zero comprimento se ele já existir.
O_EXCL (0x80): Garante que o arquivo seja criado exclusivamente (falha se o arquivo já existir).


Exemplo com criação do arquivo e permissões:
```
mov eax, 5          ; syscall: sys_open
mov ebx, filename   ; nome do arquivo
mov ecx, 0x601      ; O_FLAGS: O_WRONLY | O_CREAT | O_TRUNC
mov edx, 0644      ; permissões do arquivo (rw-r--r--)
int 0x80            ; chamada ao kernel
```

Note que em `mov ecx, 0x601` o `0x601` e por causa de uma conta:

O_WRONLY (1): Abre o arquivo para escrita (valor 1).
O_CREAT (0x40): Cria o arquivo se ele não existir (valor 0x40).
O_TRUNC (0x200): Trunca o arquivo para zero comprimento se ele já existir (valor 0x200).

(SOMA)
O_WRONLY | O_CREAT | O_TRUNC
=   1    |  0x40   | 0x200
=  0x001 |  0x040 | 0x200 
=  0x601



Agora sobre as permissões:
```
mov edx, 0644      ; permissões do arquivo (rw-r--r--)
```

Estrutura das permissões:
As permissões podem ser representadas por um número de 9 bits, dividido em 3 grupos de 3 bits cada. Cada grupo define as permissões para um tipo de usuário:

Dono do arquivo (user)
Grupo (group)
Outros usuários (others)

Cada bit pode ter os seguintes significados:

r (read): Permissão de leitura (valor 4).
w (write): Permissão de escrita (valor 2).
x (execute): Permissão de execução (valor 1).

A representação octal das permissões é formada combinando os valores desses bits. Por exemplo, rw-r--r-- seria representado como 0644.

Como as permissões são configuradas:
O valor 0644 em octal se divide da seguinte forma:

Dono: rw- → leitura e escrita (4 + 2 = 6)
Grupo: r-- → somente leitura (4)
Outros usuários: r-- → somente leitura (4)
Portanto, 0644 em octal é interpretado como:

Dono: Permissão de leitura e escrita (6)
Grupo: Permissão de leitura (4)
Outros: Permissão de leitura (4)


Então, as combinações de permissões ficam assim:

r (leitura): 4
w (escrita): 2
x (execução): 1
Agora, combinando essas permissões, você tem:

rw (leitura + escrita): 4 + 2 = 6
rx (leitura + execução): 4 + 1 = 5
wx (escrita + execução): 2 + 1 = 3
rwx (leitura + escrita + execução): 4 + 2 + 1 = 7

Tabela de permissões (em octal):
Permissão	Binário	    Octal
---	        000         0
--x	        001	        1
-w-	        010	        2
-wx	        011	        3
r--	        100	        4
r-x	        101	        5
rw-	        110	        6
rwx	        111	        7


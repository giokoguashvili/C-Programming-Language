# Assembly
Linux system calls located in `unistd.h` file
```
$ vi /usr/include/asm/unistd.h
```
32-bit
```as
$ nasm -f elf main.asm -o main.o 
$ ld -m elf_i386 -s main.o -o main.out
$ ./main.out
```
64-bit
```as
$ nasm -f elf64 hello.asm -o hello.o 
$ ld hello.o -o hello
$ ./hello
```
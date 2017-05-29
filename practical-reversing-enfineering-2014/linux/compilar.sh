#!/bin/bash
yasm -f elf64 $1.asm
ld -m elf_x86_64 -o $1 $1.o

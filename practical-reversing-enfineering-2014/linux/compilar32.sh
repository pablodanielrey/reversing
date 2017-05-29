#!/bin/bash
yasm -m x86 -f elf32 -o $1.o $1.asm
ld -m elf_i386 -o $1 $1.o

#!/bin/bash
yasm -f elf32 elf32.asm
ld -m elf_i386 -o elf32 elf32.o

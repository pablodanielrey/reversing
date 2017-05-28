#!/bin/bash
yasm -f elf64 elf64.asm
ld -m elf_x86_64 -o elf64 elf64.o

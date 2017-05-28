#!/bin/bash
yasm -f elf32 ch1-p10.asm
ld -o ch1-p10 -m elf_i386 ch1-p10.o

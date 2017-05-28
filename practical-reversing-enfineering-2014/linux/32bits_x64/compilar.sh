#!/bin/bash
yasm -f elfx32 elf32.asm
ld -m elf32_x86_64 -o elf32 elf32.o

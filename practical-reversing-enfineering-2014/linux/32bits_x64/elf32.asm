
section .text
  global _start

  _start:

    ; syscall exit de linux
    mov eax, 0x3c
    syscall

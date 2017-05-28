
section .text
  global _start

  _start:

    ; syscall exit de linux 64bits
    mov rax, 0x3c
    syscall

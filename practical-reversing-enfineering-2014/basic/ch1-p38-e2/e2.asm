
section .text
global _start
  _start:
    mov rax, _next
  _next:
    mov rax, 0x3c
    syscall

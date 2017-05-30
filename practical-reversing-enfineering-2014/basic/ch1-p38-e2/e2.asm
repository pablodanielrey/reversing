
section .text
global _start
  _start:
    jmp _f1

  _f1:
    mov rax, _next
  _next:
    TIMES 8 nop

  _f2:
    mov rax, [rip]
    TIMES 8 nop

    mov rax, 0x3c
    syscall

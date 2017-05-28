
section .text
  global _start

  _start:
    xor eax, eax
    mov ebx, edi
    repne scasd
    sub edi, ebx

    ; exit
    mov rax, 0x3c
    syscall

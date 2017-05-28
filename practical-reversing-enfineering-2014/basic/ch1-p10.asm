BITS 32

section .text
  global _start

  _start:
    xor eax, eax
    mov ebx, edi
    repne scasd
    sub edi, ebx

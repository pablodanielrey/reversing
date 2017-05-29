
; ejercicio1 - como obtener la dirección siguiente del call

section .text
  global _start
  _start:
    call _geteip
  _geteip:
    pop rax               ; dentro de rax tengo el contenido de reip

    mov rax,0x3c
    syscall

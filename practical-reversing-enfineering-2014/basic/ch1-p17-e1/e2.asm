
; ejercicio2 - secuencias para setear rip a 0xaabbccdd
; en vez de setear 0xaabbccdd voy a setear las direcciones de las secciones a ejecutar.

section .text
  global _start
  _start:
    jmp _sec1

  _sec1:
    mov rax, _sec2
    push rax
    ret                     ; obtiene el valor del stack y lo asigna a rip (hace un call a sec2)

  _sec2:
    sub rsp, 0xf            ; OJO que aunque sean 8 bytes a usar del stack, este DEBE ESTAR ALINEADO a 16 bytes!!! requerimientos de x86_64
    mov rax, _exit
    mov [rsp], rax
    ret                     ; obtiene el valor del stack y lo asigna a rip (hace un call a exit)

  _exit:
    mov rax,0x3c
    syscall


; ejercicio2 - secuencias para setear rip a 0xaabbccdd
; en vez de setear 0xaabbccdd voy a setear las direcciones de las secciones a ejecutar.

section .text
  global _start
  _start:
    jmp _sec1

  _sec1:
    mov eax, _sec2
    push eax
    ret                     ; obtiene el valor del stack y lo asigna a rip (hace un call a sec2)

  _sec2:
    sub esp, 4
    mov [esp], dword _exit
    ret                     ; obtiene el valor del stack y lo asigna a rip (hace un call a exit)

  _exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

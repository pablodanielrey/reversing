
section .data
  buffer:
    db 'prueba de buffer hasta que se finaliza con 0', 0

section .text
  global _start
  _start:
    push byte 'b'
    push dword buffer

    call func

    add rsp, 4

    ; exit
    mov eax, 0x3c
    syscall


  func:
      push rbp
      mov rbp, rsp

      ; codigo del libro
      mov edi, [rbp+8]
      mov edx, edi
      xor eax, eax
      or ecx, 0xffffffff
      repne scasb
      add ecx, 2
      neg ecx
      mov al, [rbp+0xc]
      mov edi, edx
      rep stosb                         ; tira violacion de segmento
      mov eax, edx
      ; fin del codigo del libro

      mov rsp, rbp
      pop rbp
      ret

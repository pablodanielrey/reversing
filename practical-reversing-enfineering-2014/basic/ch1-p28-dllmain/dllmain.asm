; BOOL __stdcall DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
_DllMain@12 proc near
  push ebp                  -- prologo de la función, stdcall implica parametros por stack y debo limpiar los parametros en los ret.
  mov ebp, esp
  sub esp, 130h             -- 0x130 espacio para variables locales.
  push edi                  -- resguarda edi
  sidt fword ptr [ebp-8]    -- almacena la dirección de la idt en la primera variale local.
  mov eax, [ebp-6]          -- obtiene la dirección base de la idt en eax
  cmp eax, 8003F400h        -- compara la dirección base contra 0x8003f400
  jbe short loc_10001C88    -- si es menor o igual (operación sin signo!!) salta a loc....
  cmp eax, 80047400h        -- compara contra 0x80047400
  jnb short loc_10001C88    -- si es mayor o igual (operación sin signo!!!) salta a loc....
  xor eax, eax              -- eax = 0
  pop edi                   -- restaura edi (no usado en ningun lado)
  mov esp, ebp              -- restaura el stack
  pop ebp
  retn 0xc                  -- retorna limpiando los 10 bytes de parámetros del stack

loc_10001C88:
  xor eax, eax                      -- eax = 0
  mov ecx, 49h                      -- ecx = 0x49
  lea edi, [ebp-12Ch]               -- leo en edi la dirección de un buffer -- parte 2 de PROCESSSENTRY32
  mov dword ptr [ebp-130h], 0       -- la primer variable local la pongo a cero -- dwSize de PROCESSENTRY32
  push eax                          -- parámetro
  push 2                            -- parámetro
  rep stosd                         -- limpio 0x49 * 4 = 0x124 bytes desde edi.
  call CreateToolhelp32Snapshot     -- CreateToolHelp32Snapshot(2,0)
  mov edi, eax                      -- valor de retorno en edi
  cmp edi, 0FFFFFFFFh               -- comparo si edi por INVALID_HANDLE_VALUE
  jnz short loc_10001CB9            -- si no son iguales entonces salto a loc....
  xor eax, eax                      -- limpio valor de reotnro de la función
  pop edi                           -- restauro edi
  mov esp, ebp                      -- restauro el stack
  pop ebp
  retn 0xc                          -- retorno limpiando los 10 bytes de parámetros

loc_10001CB9:
  lea eax, [ebp-130h]               -- eax = dirección de la variable local (PROCESSENTRY32)
  push esi                          -- guardo esi para poder modificarlo
  push eax                          -- parámetro (puntero a variable local PROCESSENTRY32)
  push edi                          -- parámetro (retorno de Crea... handle)
  mov dword ptr [ebp-130h], 128h    -- variable local = 0x128
  call Process32First               -- Process32First(handle, &procentry32)
  test eax, eax
  jz short loc_10001D24             -- si el retorno es FALSE (o sea 0) salta a loc...
  mov esi, ds:_stricmp              -- esi apunta a stricmp
  lea ecx, [ebp-10Ch]               -- ecx = procentry32.szExeFile
  push 10007C50h                    -- parámetro
  push ecx                          -- parámetro
  call esi ; _stricmp               -- _stricmp(procentry32.szExeFile, 0x10007c50)
  add esp, 8                        -- saco los parametros porque es _cdecl
  test eax, eax
  jz short loc_10001D16             -- si retorna False (o sea 0) entonces salto a loc...

loc_10001CF0:
  lea edx, [ebp-130h]               -- edx = &procentry32
  push edx                          -- parámetro
  push edi                          -- parámetro (handle)
  call Process32Next                -- Process32Next(handle, &procentry32)
  test eax, eax                     --
  jz short loc_10001D24             -- si es cero salta a finalizar con return 0
  lea eax, [ebp-10Ch]               -- procentry32.szExeFile
  push 10007C50h                    -- parámetro
  push eax                          -- parámetro
  call esi ; _stricmp               -- stricmp(procentry32.szExeFile, 0x10007c50)
  add esp, 8                        -- saco los parámetros ya que es __stdcall
  test eax, eax
  jnz short loc_10001CF0            -- si no son iguales repito

loc_10001D16:
  mov eax, [ebp-118h]               -- procentry32.th32ParentProccessID
  mov ecx, [ebp-128h]               -- procentry32.th32ProcessID
  jmp short loc_10001D2A            -- salto a comparar

loc_10001D24:
  mov eax, [ebp+0Ch]                -- fdwReason
  mov ecx, [ebp+0Ch]                -- fdwReason

loc_10001D2A:
  cmp eax, ecx                      -- comparo si son iguales
  pop esi                           -- restauro esi
  jnz short loc_10001D38            -- si no son iguales entonces salgo a loc...
  xor eax, eax                      -- valor de retorno 0
  pop edi                           -- restaura edi
  mov esp, ebp                      -- restaura stack
  pop ebp
  retn 0xc                          -- retorna 0, es _stdcall

loc_10001D38:
  mov eax, [ebp+0Ch]                -- eax = hinstDLL
  dec eax                           -- eax = eax - 1
  jnz short loc_10001D53            -- salta si no es cero. o sea si hinstDll > 1
  push 0                            -- parámetro
  push 0                            -- parámetro
  push 0                            -- parámetro
  push 100032D0h                    -- parámetro
  push 0                            -- parámetro
  push 0                            -- parámetro
  call ds:CreateThread              -- CreateThread(0,0, 0x100032d0, 0, 0, 0)

loc_10001D53:
  mov eax, 1                        -- eax = 1
  pop edi                           -- restauro edi
  mov esp, ebp                      -- restauro stack
  pop ebp
  retn 0xc                          -- retorno 1, es _stdcall

_DllMain@12 endp

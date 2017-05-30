
struct idtr {
  WORD limit;
  DWORD baseAddr;
}

struct PROCESSENTRY32 {
  DWORD dwSize;
  ...
  ...
  ...
}


BOOL __stdcall DllMain8(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved) {

    PROCESSENTRY32 procentry32;
    idtr idt = obtenerIdtr;

    if (idt.baseaddr > 0x8003f400 && idt.baseAddr < 0x80047400) {
      return 0;
    }

    //---
    // en assembler realiza estos pasos, que se pueden resumir a lo siguiente
    // procentry32.dwSwize = 0;
    // zeromemory(((char *)&procentry32 + 4), 0x124);
    //----
    zeromemory(&procentry32, 0x128)

    HANDLE handle = CreateToolHelp32Snapshot(2, 0) // incluye a todos los procesos del thread 0 -- proceso actual
    if (handle == -1) {
      return 0;
    }

    procentry32.dwSize = 0x128;
    if (Process32First(handle, &procentry32) == 0) {
        /*
            en este caso realiza la comparación en loc_100001D2A pero siempre va a ser igual.
            o sea que retorna 0
        */
        return 0;
    }

    if (stricmp(procentry32.szExeFile, 0x10007c50) == 0) {

        if (procentry32.th32ParentProcessID == procentry32.th32ProcessID) {
          return 0;
        }

        if (fwdReason == 0) {
          return 0;
        }
        if (fwReason > 1) {
          return 1;
        }

        CreateThread(0, 0, 0x100032d0, 0, 0, 0);
        return 1;

    } else {

        while (1) {
          if (Process32Next(handle, &procentry32) == 0) {
            return 0;
          } else {

             if (stricmp(procentry32.szExeFile, 0x10007c50) == 0) {

               if (procentry32.th32ParentProcessID == procentry32.th32ProcessID) {
                 return 0;
               }

               if (fwdReason == 0) {
                 return 0;
               }
               if (fwReason > 1) {
                 return 1;
               }

               CreateThread(0, 0, 0x100032d0, 0, 0, 0);
               return 1;

             }

          }
        }
    }

}

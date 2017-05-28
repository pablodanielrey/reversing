
import sys
from capstone import *

if __name__ == '__main__':

    if len(sys.argv) <= 1:
        print('disasm.py archivo')
        sys.exit(1)

fi = sys.argv[1]
print('Desensamblando {}'.format(fi))
with open(sys.argv[1], 'rb') as f:
    md = Cs(CS_ARCH_X86, CS_MODE_32)
    md.syntax = CS_OPT_SYNTAX_INTEL
    md.skipdata = False
    for i in md.disasm(f.read(), 0x1000):
        print("0x{}:\t{}\t{}".format(i.address, i.mnemonic, i.op_str))

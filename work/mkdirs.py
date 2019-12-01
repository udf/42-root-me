import os

names = '''
Bash - System 1
Bash - System 2
ELF32 - PID encryption
ELF x86 - Format string bug basic 1
ELF x86 - Stack buffer overflow basic 1
ELF x64 - Stack buffer overflow basic
ELF x86 - Stack buffer overflow basic 2
ELF x86 - BSS buffer overflow
ELF x86 - Stack buffer overflow basic 4
ELF x86 - Race condition
ELF x86 - Stack buffer and integer overflow
ELF x86 - Stack buffer overflow 5
ELF x86 - Remote BSS buffer overflow
ELF x86 - Remote Format String bug
'''.strip()

bonus_names = '''
ELF x86 - Hardened binary 1
ELF x86 - Hardened binary 2
ELF x86 - Hardened binary 3
ELF x86 - Hardened binary 4
ELF x86 - Hardened binary 5
ELF x86 - Hardened binary 6
ELF x86 - Hardened binary 7
'''.strip()

for i, name in enumerate(names.split('\n')):
    dirname = f'{i:02d} {name}'
    print(dirname)
    os.mkdir(dirname)

for i, name in enumerate(bonus_names.split('\n')):
    dirname = f'{i:02d} {name}'
    dirname = os.path.join('bonus', dirname)
    print(dirname)
    os.mkdir(dirname)
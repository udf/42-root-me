section .data
; crickets

section .text
global _start
_start:
; jmp ebx+163+1 (msg data, after initial '!')
mov edx, ebx
add edx, 127
add edx, 37
push edx
ret
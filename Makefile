CC = mips-linux-gnu-gcc
OBJDUMP = mips-linux-gnu-objdump
CFLAGS = -mips1 -mfp32 -g
CFLAGS+=$(OPT)
mips_program.s:
%.s: %.o
	$(OBJDUMP) -g -d $*.o > $*.s

clean:
	rm -rf *.o *.s

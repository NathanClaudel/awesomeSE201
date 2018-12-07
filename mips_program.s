	.file	1 "mips_program.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.text
	.align	2
	.globl	f
	.set	nomips16
	.set	nomicromips
	.ent	f
	.type	f, @function
f:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	lw	$2,16($fp)
	bne	$2,$0,$L2
	nop

	li	$2,-1			# 0xffffffffffffffff
	.option	pic0
	b	$L3
	nop

	.option	pic2
$L2:
	lw	$2,16($fp)
	lbu	$2,0($2)
	sb	$2,3($fp)
	sw	$0,4($fp)
	.option	pic0
	b	$L4
	nop

	.option	pic2
$L6:
	lb	$3,3($fp)
	li	$2,32			# 0x20
	beq	$3,$2,$L5
	nop

	lw	$2,4($fp)
	addiu	$2,$2,1
	sw	$2,4($fp)
$L5:
	lw	$2,16($fp)
	addiu	$2,$2,1
	sw	$2,16($fp)
	lw	$2,16($fp)
	lbu	$2,0($2)
	sb	$2,3($fp)
$L4:
	lb	$2,3($fp)
	bne	$2,$0,$L6
	nop

	lw	$2,4($fp)
$L3:
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	f
	.size	f, .-f
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"

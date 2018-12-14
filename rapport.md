# RAPPORT SE 201

## 1. MIPS Instruction Set

0: 1080000d   
BEQ $a0 *(registre4)* $zero *(registre0)* 0x000d    
Si le premier argument de la fonction est nul, on saute à l'instruction 38.   


4: 00000000   
NOP   


8: 80850000  
LB $a1 *(registre5)* 0x0000 $a0 *(registre4)*   
On charge dans le registre a1 ce qui se trouve ne mémoire à l'adresse a0 (a1<-Mém[a0]) avec une extension de signe.   


c: 00000000   
NOP   


10: 10a00007   
BEQ $a1 *(registre5)* $zero *(registre0)* 0x0007     
Si la valeur du registre a1 est nulle, on saute à l'instruction 20.  


14: 00001025   
OR $v0 *(registre2)* $zero *(registre0)* $zero *(registre0)*  
Le registre v0 reçoit la valeur 0.   


18: 24840001   
ADDIU $a0 *(registre4)* $a0 *(registre4)* 0x0001     
Incrémentation de 1 de la valeur se trouvant dans le registre a0.   


1c: 38a30020  
XORI $v1 *(registre3)* $a1 *(registre5)* 0x0020   
On met dans le registre v1 le résultat de l'opération xor entre la valeur du registre a1 et 20.   


20: 80850000  
LB $a1 *(registre5)* 0x0000 $a0 *(registre4)*  
On charge dans le registre a1 ce qui se trouve ne mémoire à l'adresse a0 (a1<-Mém[a0]) avec une extension de signe.  


24: 0003182b  
SLTU $v1 *(registre3)* $zero *(registre0)* $v1 *(registre3)*   
Si la valeur du registre v1 est strictement supérieure à 0, on met cette valeur à 1, sinon on la met à zéro.  


28: 14a0fffb  
BNE $a1 *(registre5)* $zero *(registre0)* 0xFFFB   
Si la valeur du registre a1 est différente de 0, on saute à l'instruction 18.    


2c: 00431021   
ADDU $v0 *(registre2)* $v0 *(registre2)* $v1 *(registre3)*   
La valeur de v0 devient la valeur de v0 additionnée à celle de v1 (addition non signée).   


30: 03e00008   
JR $ra *(registre31)*  
On sort de la fonction.   


34: 00000000  
NOP  


38: 03e00008  
JR $ra *(registre31)*  
On sort de la fonction.   


3c: 2402ffff   
ADDIU $v0 *(registre2)* $zero *(registre0)* 0xFFFF   
La valeur de v0 devient 0xFFFF avec extension de signe.  


**But de la fonction :**  
Retourner le nombre de caractères sauf les espaces d'une chaînes de caractères.  


## 2. MIPS Tool Chain


Code C équivalent  à la fonction :  
```
int f(char *str)
{
    if(str == 0) return -1;

    char a1 = *str;

    int cpt = 0;

    while(a1 != 0)
    {
        if(a1 != 0x20) cpt++;

        str ++;
        a1 = *str;
    }

    return cpt;
}  
```

Code assembleur obtenue en désassemblant le programme C :
```
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
```

On voit a de nombreuses reprises des instructions lw avec fp (qui est synonyme de s8).

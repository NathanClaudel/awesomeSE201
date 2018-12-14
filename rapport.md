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
0:	27bdfff0 	addiu	sp,sp,-16
4:	afbe000c 	sw	s8,12(sp)
8:	03a0f025 	move	s8,sp
c:	afc40010 	sw	a0,16(s8)
10:	8fc20010 	lw	v0,16(s8)
14:	00000000 	nop
18:	14400004 	bnez	v0,2c <f+0x2c>
1c:	00000000 	nop
20:	2402ffff 	li	v0,-1
24:	1000001f 	b	a4 <f+0xa4>
28:	00000000 	nop
2c:	8fc20010 	lw	v0,16(s8)
30:	00000000 	nop
34:	90420000 	lbu	v0,0(v0)
38:	00000000 	nop
3c:	a3c20003 	sb	v0,3(s8)
40:	afc00004 	sw	zero,4(s8)
44:	10000012 	b	90 <f+0x90>
48:	00000000 	nop
4c:	83c30003 	lb	v1,3(s8)
50:	24020020 	li	v0,32
54:	10620005 	beq	v1,v0,6c <f+0x6c>
58:	00000000 	nop
5c:	8fc20004 	lw	v0,4(s8)
60:	00000000 	nop
64:	24420001 	addiu	v0,v0,1
68:	afc20004 	sw	v0,4(s8)
6c:	8fc20010 	lw	v0,16(s8)
70:	00000000 	nop
74:	24420001 	addiu	v0,v0,1
78:	afc20010 	sw	v0,16(s8)
7c:	8fc20010 	lw	v0,16(s8)
80:	00000000 	nop
84:	90420000 	lbu	v0,0(v0)
88:	00000000 	nop
8c:	a3c20003 	sb	v0,3(s8)
90:	83c20003 	lb	v0,3(s8)
94:	00000000 	nop
98:	1440ffec 	bnez	v0,4c <f+0x4c>
9c:	00000000 	nop
a0:	8fc20004 	lw	v0,4(s8)
a4:	03c0e825 	move	sp,s8
a8:	8fbe000c 	lw	s8,12(sp)
ac:	27bd0010 	addiu	sp,sp,16
b0:	03e00008 	jr	ra
b4:	00000000 	nop
```

On voit a de nombreuses reprises des instructions lw avec s8. s8 est aussi nommé fp (frame pointer). C'est ce registre qui sert a sauvegarder l'adresse du stack pointer avant l'appel d'une fonction.
Ici il est surtout utilisé comme point de référence pour stocker ou charger des mots de 32bits (sw et lw) ou des octets (sb et lb) en ajoutant un offset le tout dans la pile plutôt que dans la mémoire.


Compiler avec des optimisations réduit et le code et en O3 il n'y a plus de référence à s8.
```
0:	1080000f 	beqz	a0,40 <f+0x40>
4:	00000000 	nop
8:	80830000 	lb	v1,0(a0)
c:	00000000 	nop
10:	10600009 	beqz	v1,38 <f+0x38>
14:	00001025 	move	v0,zero
18:	24050020 	li	a1,32
1c:	10650002 	beq	v1,a1,28 <f+0x28>
20:	24840001 	addiu	a0,a0,1
24:	24420001 	addiu	v0,v0,1
28:	80830000 	lb	v1,0(a0)
2c:	00000000 	nop
30:	1460fffa 	bnez	v1,1c <f+0x1c>
34:	00000000 	nop
38:	03e00008 	jr	ra
3c:	00000000 	nop
40:	03e00008 	jr	ra
44:	2402ffff 	li	v0,-1
```

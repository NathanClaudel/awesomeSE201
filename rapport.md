# RAPPORT SE 201

## 1. MIPS Instruction Set

### Décodage des instructions

0: 1080000d

BEQ $a1 *(registre5)* $zéro 0x000d  

Si le deuxième argument de la fonction est nul, on saute à l'instruction 38.


4: 00000000

NOP


8: 80850000

LB $a1 *(registre5)* 0x0000 $a0  

On charge dans le registre a1 ce qui se trouve ne mémoire à l'adresse a0 (a1<-Mém[a0]) avec une extension de signe.


c: 00000000

NOP


10: 10a00007

BEQ $a1 $zéro 0x0007  

Si la valeur du registre a1 est nulle, on saute à l'instruction 20.


14: 00001025

OR $v0 $zéro $zéro

Le registre v0 reçoit la valeur 0.


18: 24840001

ADDIU $a0 $a0 0x0001  

Incrémentation de 1 de la valeur se trouvant dans le registre a0.


1c: 38a30020

XORI $v1 $a1 0x0020

On met dans le registre v1 le résultat de l'opération xor entre la valeur du registre a1 et 20.


20: 80850000

LB $a1 0x0000 $a0

On charge dans le registre a1 ce qui se trouve ne mémoire à l'adresse a0 (a1<-Mém[a0]) avec une extension de signe.


24: 0003182b

SLTU $v1 $zéro $v1

Si la valeur du registre v1 est strictement supérieure à 0, on met cette valeur à 1, sinon on la met à zéro.


28: 14a0fffb

BNE $a1 $zéro 0xFFFB

Si la valeur du registre a1 est différente de 0, on saute à 18.


2c: 00431021

ADDU $v0 $v0 $v1

La valeur de v0 devient la valeur de v0 additionnée à celle de v1 (addition non signée).


30: 03e00008

JR $ra

On sort de la fonction.


34: 00000000

NOP


38: 03e00008

JR $ra

On sort de la fonction.


3c: 2402ffff

ADDIU $v0 $zéro 0xFFFF

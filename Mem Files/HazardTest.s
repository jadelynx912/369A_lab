.data 

.text				# Put program here 
.globl main			# globally define 'main' 


main: addi $t1, $zero, 3		#3
addi $t0, $zero, 4				#4
addi $t1, $t0, 2				#6
mul $t2, $t0, $t1				#18

lw $t3, 4($zero)
sub $t4, $t3, $t0
sw $t4, 8($zero)
lw $t5, 8($zero)

lw $t3, 0($t0)
addi $t0, $t0, 12
sw $t3, 0($t0)

addi $t5, $t0, 4				
bne $t5, $t0, part2
addi $t6, $t0, 12

part2: sub $t5, $t5, $zero
bne $t5, $t0, part3


part3: addi $t0, $zero, 13
jr $t0
addi $t7, $t7, 13

.end
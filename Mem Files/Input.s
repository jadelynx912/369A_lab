.data 

.text				# Put program here 
.globl main			# globally define 'main' 


main: addi $t0, $zero, 8  # ==8
nop
nop
nop
nop
nop
addi $t1, $zero, 6 # == 6
nop
nop
nop
nop
nop
add $t2, $t0, $t1 # == 14
nop
nop
nop
nop
nop
sub $t2, $t0, $t1 # == 2
nop
nop
nop
nop
nop
mul $t2, $t0, $t1 # == 48
nop
nop
nop
nop
nop
lw $s0, 0($t0) # == 8
nop
nop
nop
nop
nop
sw $t0, 0($t2) # == 8
nop
nop
nop
nop
nop


#logical
add $t0, $zero, $zero
nop
nop
nop
nop
nop
addi $t1, $zero, 1
nop
nop
nop
nop
nop
and $t2, $t0, $t1 # == 0
nop
nop
nop
nop
nop
andi $t2, $t1, 1 # == 1
nop
nop
nop
nop
nop
or $t2, $t0, $t1 # == 1
nop
nop
nop
nop
nop
nor $t2, $t0, $t1 # == 0
nop
nop
nop
nop
nop
xor $t2, $t0, $t1 # == 1
nop
nop
nop
nop
nop
ori $t2, $t0, 0 # == 0
nop
nop
nop
nop
nop
xori $t2, $t1, 1 # == 0
nop
nop
nop
nop
nop
sll $t2, $t1, 2 # == 4
nop
nop
nop
nop
nop
srl $t2, $t2, 2 # == 1
nop
nop
nop
nop
nop
slt $t2, $t0, $t1 # == 1
nop
nop
nop
nop
nop
slti $t2, $t1, 0 # == 0
nop
nop
nop
nop
nop

#Branches
addi $t0, $zero, 8 # ==8
nop
nop
nop
nop
nop
addi $t1, $zero, 6 # == 6
nop
nop
nop
nop
nop
addi $t2, $zero, -8
nop
nop
nop
nop
nop

bgez $t1, branch1
nop
nop
nop
nop
nop

addi $t6, $zero, 404
nop
nop
nop
nop
nop

branch1: beq $t0, $t0, branch2
nop
nop
nop
nop
nop

addi $t6, $zero, 404
nop
nop
nop
nop
nop

branch2: bne $t0, $t1, branch3
nop
nop
nop
nop
nop

addi $t6, $zero, 404
nop
nop
nop
nop
nop

branch3: bgtz $t0, branch4
nop
nop
nop
nop
nop

addi $t6, $zero, 404
nop
nop
nop
nop
nop

branch4: blez $t2, branch5
nop
nop
nop
nop
nop

addi $t6, $zero, 404
nop
nop
nop
nop
nop

branch5: bltz $t2, branch6
nop
nop
nop
nop
nop

addi $t6, $zero, 404
nop
nop
nop
nop
nop

branch6: j jump1
nop
nop
nop
nop
nop

addi $t6, $zero, 404
nop
nop
nop
nop
nop

jump1: jal jump2
nop
nop
nop
nop
nop

addi $t6, $zero, 424
nop
nop
nop
nop
nop

jump2: jr $ra
nop
nop
nop
nop
nop



.end
.data 

.text				# Put program here 
.globl loop			# globally define 'main' 

loop: addi $t0, $zero, $zero # t0=0, display 0, 0
nop
nop
nop
nop
nop
addi $t1, $zero, 6 # t1= 6, display 24, 6
nop
nop
nop
nop
nop
addi $t2, $zero, 10 # t2 = 10, display 48, 10
nop
nop
nop
nop
nop
sw $t1, 0($t0) # display 72, (no register written)
nop
nop
nop
nop
nop
sw $t2, 4($t0) # display 96,
nop
nop
nop
nop
nop
lw $s0, 0($t0) # s0 = 6, display 120, 6
nop
nop
nop
nop
nop
lw $s1, 4($t0) # s1 = 10, display 144, 10
nop
nop
nop
nop
nop
sub $t3, $s1, $s0 # t3 = 10-6 = 4, display 168, 4
nop
nop
nop
nop
nop
sll $t4, $t3, 3 # t4 = 4 << 3 = 64, display 192, 64
nop
nop
nop
nop
nop
srl $t5, $t4, 2 # t5 = 16 64 >> 2, display 216, 2
nop
nop
nop
nop
nop
j loop # display 240,

.end
PC=0 loop: addi $t0, $zero, $zero # t0=0, display 0, 0
nop
nop
nop
nop
nop
PC=24 addi $t1, $zero, 6 # t1= 6, display 24, 6
nop
nop
nop
nop
nop
PC=48 addi $t2, $zero, 10 # t2 = 10, display 48, 10
nop
nop
nop
nop
nop
PC=72 sw t1, 0($t0) # display 72, (no register written)
nop
nop
nop
nop
nop
PC=96 sw t2, 4($t0) # display 96,
nop
nop
nop
nop
nop
PC=120 lw s0, 0($t0) # s0 = 6, display 120, 6
nop
nop
nop
nop
nop
PC=144 lw s1, 4($t0) # s1 = 10, display 144, 10
nop
nop
nop
nop
nop
PC=168 sub $t3, s1, s0 # t3 = 10-6 = 4, display 168, 4
nop
nop
nop
nop
nop
PC=192 sll $t4, $t3, 3 # t4 = 4 << 3 = 64, display 192, 64
nop
nop
nop
nop
nop
PC=216 srl $t5, $t4, 2 # t5 = 16 64 >> 2, display 216, 2
nop
nop
nop
nop
nop
PC=240 j loop # display 240,
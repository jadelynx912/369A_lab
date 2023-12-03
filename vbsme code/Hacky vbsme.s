#  Fall 2022
#  Team Members:    
#  % Effort    :   
#
# ECE369A,  
# 

########################################################################################################################
### data
########################################################################################################################
.data
   

# test 5 For the 32X32 frame and a 4X4 window size
# The result should be 17, 16 since its the last of multiple repeating occurences
asize5: .word    32, 32, 4, 4    #i, j, k, l
frame5: .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
         .word    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
                  
window5:   .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10, 
            .word    10, 10, 10, 10

newline: .asciiz     "\n" 


########################################################################################################################
### main
########################################################################################################################

.text

.globl main

main: 
    addi    $sp, $sp, -4    # Make space on stack
    sw      $ra, 0($sp)     # Save return address
  
   # Start test 5
   ############################################################
   la      $a0, asize5     # 1st parameter: address of asize5[0]
   la      $a1, frame5     # 2nd parameter: address of frame5[0]
   la      $a2, window5    # 3rd parameter: address of window5[0] 

   jal     vbsme           # call function
   jal     print_result    # print results to console
   ############################################################
   # End of test 5


    lw      $ra, 0($sp)         # Restore return address
    addi    $sp, $sp, 4         # Restore stack pointer
    j       end_program                 # Return

end_program:                    # remain in infinite loop
	j end_program
################### Print Result ####################################
print_result:
   # Printing $v0
    add     $a0, $v0, $zero     # Load $v0 for printing
    li      $v0, 1              # Load the system call numbers
    syscall
   
    # Print newline.
    la      $a0, newline          # Load value for printing
    li      $v0, 4                # Load the system call numbers
    syscall
   
    # Printing $v1
    add     $a0, $v1, $zero      # Load $v1 for printing
    li      $v0, 1                # Load the system call numbers
    syscall

    # Print newline.
    la      $a0, newline          # Load value for printing
    li      $v0, 4                # Load the system call numbers
    syscall
   
    # Print newline.
 #   la      $a0, newline          # Load value for printing
 #   li      $v0, 4                # Load the system call numbers
 #   syscall
   
 #   jr      $ra                   #function return

.text
.globl  vbsme

# Begin subroutine
vbsme:  
    add $v0, $zero, $zero            # reset $v0 and $V1
    add $v1, $zero, $zero

        # insert your code here
vars:
    addi $s0, $zero, 4             #rows/cols of window
    addi $s1, $zero, 32            #rows/cols of frame
    addi $s2, $zero, 29            #frameRows - windowRows + 1 and frameCols - windowCols + 1

    addi $s7, $zero, 32767        #set minsad
    addi $t0, $zero, 0              #i = 0
    addi $t1, $zero, 0              #j = 0
   
                            #Used t2 and t3 later for k and l


mainloop:
    slt $t8, $s2, $t0           #61 < i - should be 0, if 1 i==61 which is wrong
    slt $t9, $s2, $t1           #61 < j
    add $s6, $zero, $zero       # sad = 0
    or $t7, $t8, $t9            # if 1 we've gone too far
    add $t2, $zero, $zero       #k = 0
    bne $t7, $zero, exit        # exit if the result is not 0, want it to be 0
    

outerfor:
    slt $t7, $t2, $s0           #k < 4
    add $t3, $zero, $zero       #l = 0
    beq $t7, $zero, setmincondition     #exit the loop if that's false
    j innerfor

innerfor:
    slt $t8, $t3, $s0                   # l < wcols
    beq $t8, $zero, outerforadd         # exit the loop if that's false
    #calc sad - using t6-t9, s6 for curent sad, 7 for minsad
    
    add $t6, $t0, $t2           #i + k
    add $t7, $t1, $t3           #j + 1
    mul $t6, $s0, $t6           # rows (t6) * wcols (zero based indexing so don't subtract)
    add $t6, $t7, $t6           # rows * cols + cols
    sll, $t6, $t6, 2            # multiply index for 1D array *4
    add $t6, $a1, $t6           # Add to base address
    lw $t8, 0($t6)              # Get frame[i+k, j+l]

    mul $t7, $s1, $t2           # k * fcols
    add $t7, $t7, $t3           # add l to k*fcols
    sll $t7, $t7, 2             # multiply index for 1D array *4
    add $t7, $a2, $t7           # Add base address
    lw $t9, 0($t7)              # Get window[k, l]

    sub $t7, $t8, $t9           #$t8-$t9 (frame[i+k, j+l] - window[k, l])
    slt $t6, $t7, $zero
    beq $t6, $zero, positive    # If positive, skip next line
    sub $t7, $zero, $t7         #subtract t7 from 0 to get -(t7)

positive: #Continuation of innerfor
    add $s6, $t7, $s6           #Set $s6 to current sad

addinnerfor:
    addi $t3, $t3, 1                #Add 1 to l
    j innerfor                      #Loop

outerforadd:                    #after the inner for loop, add 1 to k
    addi $t2, $t2, 1            #and jump back to the outer loop
    j outerfor


setmincondition:
    #Check if sad <= minsad - will trigger on first iteration
    slt $t9, $s7, $s6               #want it to be 0
    bne $t9, $zero, endfors         #branch if not 0

setmin:
    add $s7, $s6, $zero             #Minsad = sad
    add $v0, $t0, $zero             #v0 (bestrow) = i
    add $v1, $t1, $zero             #v1 (bestcol) = j
    
endfors:
    addi $t1, $t1, 1        #j += 1
    bne $t1, $s2, mainloop
    addi $t0, $t0, 1
    add $t1, $zero, $zero
    j mainloop                  

exit:
    jr $ra


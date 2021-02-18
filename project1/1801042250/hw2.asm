.data
poss:   .asciiz "\nPossible!\n"
npos:  .asciiz "\nNot Possible!\n"
space: .asciiz " "

array:   .word 800

.text
main:
	jal read
	
	move $t5, $t0
	move $t8, $t1
	
	jal pos
	
exit_loop:

	jal print_res
	
	jal exit

pos:
	subu $sp, $sp, 12
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	move $s0, $t0 #size
	move $s1, $t1 #num
	
	beq $s1, $zero, return1 # if ( num == 0 )
	beq $s0, $zero, return0_size # if ( size == 0 )
	blt $s1, $zero, return0_num # if ( num < 0 )
	
	subi $t0, $s0, 1
	sll $t4, $t0, 2
	lw $a0, array($t4)
	
	sub $t1, $s1, $a0
		
	jal pos	

	subi $t0, $s0, 1
	#move $t1, $t8

	jal pos

		return:
			lw $ra, ($sp)
			lw $s0, 4($sp)
			lw $s1, 8($sp)
			addu $sp, $sp, 12
			jr $ra
		return0_num:
			add $t1, $s1, $a0
			li $t7, 0
			j return
		return0_size:
			subi $t5, $t5, 1
			move $t0, $t5
			li $t7, 0
			j return
		return1:
			li $t7, 1
			j exit_loop
	
.globl read
read:
	#size
	li $v0, 5
	syscall
	move $t0, $v0
	#numb
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $t3, 0
	li $t4, 0
	
read_loop:
	li $v0, 5
	syscall
	move $a0, $v0  
	sw $a0, array($t4)
	
	addi $t3, $t3, 1
	addi $t4, $t4, 4
	bne $t3, $t0, read_loop
	
	
	li $t3, 0
	li $t4, 0
	jr $ra
	
	
print_nop:
	li $v0, 4
	la $a0, npos
	syscall
	jr $ra

print_poss:
	li $v0, 4
	la $a0, poss
	syscall
	jr $ra
	
print_res:
	beq $t7, $zero, print_nop
	bne $t7, $zero, print_poss
	jr $ra

exit:
	li $v0, 10
	syscall
	jr $ra

.data
	varA:		.word 3
	varB:		.word 5
	result:		.space 4
.text
	main:
		lw $s0, varA
		lw $s1, varB
		addi $sp, $sp, -8
		
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		
		jal mult
		
		sw $v1, result
		
		li $v0, 1
   		move $a0, $v1
    		syscall
    	
    	# Terminamos el programa
    	li $v0, 10
    	move $a0, $v0
    	syscall
		 
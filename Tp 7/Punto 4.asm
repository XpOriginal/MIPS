.data
	varA:		.word 2
	varB:		.word 5

.text	
	main:
		li $v0, 1		# Imprime varA
		lw $a0, varA
		syscall
		
		jal saltarLinea
		
		li $v0, 1		# Imprime varB
		lw $a0, varB
		syscall
		
		jal saltarLinea
		
		#------------------------------------
		la $s0, varA		#swap(*a1, *a2)
		la $s1, varB
		jal swap
		#------------------------------------		
		
		jal saltarLinea
		
		jal saltarLinea
		
		li $v0, 1		# Imprime varA
		lw $a0, varA
		syscall
		
		jal saltarLinea
		
		li $v0, 1		# Imprime varB
		lw $a0, varB
		syscall
	
	# Fin del programa
	li $v0, 10
	syscall
	
	swap:
		addi $sp, $sp, -8	#Damos lugar en la pila para 3 words
		sw $s0, 0($sp)		#Insertamos "varA"	
		sw $s1, 4($sp)		#Insertamos "varB"
		
		
		lw $t0, 0($s0)		#Guardamos la direccion de varA en t0
		lw $t1, 0($s1)		#Guardamos la direccion de varB en t1
		
		sw $t1, 0($s0)		#Swap
		sw $t0, 0($s1)
		
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		addi $sp, $sp, 4
		
		jr $ra
		
		
	saltarLinea:
		li $v0, 11		# \n
		li $a0, 10
		syscall
		jr $ra
		

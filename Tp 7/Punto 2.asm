.data
	varA: 	.word 4
	varB: 	.word 2
.text
	main:

		li $v0, 1		# Imprime varA
		lw $a0, varA
		syscall
		
		li $v0, 11		# \n
		li $a0, 10
		syscall
		
		li $v0, 1		# Imprime varB
		lw $a0, varB
		syscall
		
		#------------------------------------
		la $a1, varA		#swap(*a1, *a2)
		la $a2, varB
		jal swap
		#------------------------------------		
		
		li $v0, 11		# \n
		li $a0, 10
		syscall
		
		li $v0, 11		# \n
		li $a0, 10
		syscall
		
		li $v0, 1		# Imprime varA
		lw $a0, varA
		syscall
		
		li $v0, 11		# \n
		li $a0, 10
		syscall
		
		li $v0, 1		# Imprime varB
		lw $a0, varB
		syscall
		
	# Fin del programa
	li $v0, 10
	syscall
	
	swap:	#int swap(int &a, int &b)
		lw $t0, 0($a1)	# aux1 = varA
		lw $t1, 0($a2)	# aux2 = varB
		
		sw $t1, 0($a1)	# varA = aux2
		sw $t0, 0($a2)	# varB = aux1
		jr $ra
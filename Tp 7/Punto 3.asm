.data
	n: 	.word 5
.text
	main:
		lw $s0, n
		jal calcular
		
		li $v0, 1
		move $a0, $v1
		syscall
		
	# Terminar el programa
	li $v0, 10
	syscall
	
	
	calcular:
		addi $sp, $sp, -4
		sw $s0, 0($sp)
		
		andi $t0, $s0, 1	# Si el bit mas significativo es uno, es impar... si es 0 es par
		beq $t0, $zero, esPar
		j esImpar
			
			esPar:
				srl $v1, $s0, 1		# aux = n / 2	(Dos elevado a la una)
				
				lw $s0, 0($sp)
				addi $sp, $sp, 4
				
				jr $ra
			
			esImpar:
				sll $v1, $s0, 2		# aux = n * 4	(Dos al cuadrado)
				addi $v1, $v1, 1	# aux = aux + 1
				
				lw $s0, 0($sp)
				addi $sp, $sp, 4
				
				jr $ra
	
.data
	n: 	.word 3 	# Numero n

.text
	main:
		lw $a1, n
		
		jal calcular
		
		li $v0, 1
		addi $a0, $v1, 0
		syscall
	# Fin del programa
	li $v0, 10
	syscall
	
	calcular:
		andi $t0, $a1, 1 	# Si el bit mas significativo es 1 es impar, si no es par
		beq $t0, $zero, esPar	# Chequea si es par o no es par, en caso de que sea salta hacia "esPar"
		j esImpar		# En caso de que sea impar, salta a "esImpar"
	
		esPar:
			srl $v1, $a1, 1		# aux = n / 2	(Dos elevado a la una)
			jr $ra			# return aux
		
		esImpar:
			sll $v1, $a1, 2		# aux = n * 4	(Dos elevado al cuadrado)
			addi $v1, $v1, 1	# aux = aux + 1
			jr $ra			# return aux
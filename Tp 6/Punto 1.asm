.data
	n:		.word 5
	resultado:	.word 0

.text

	main:
		lw $s0, n			#Cargamos n en el registro $s0
		andi $t0, $s0, 1		#Vemos si es par o impar (1 Impar, 0 Par)
		beq $t0, $zero, esPar		#if $t0 == 0: esPar()
		j esImpar			#else: esImpar()

	esPar:
		srl $t1, $s0, 1			#$t1 = $s0 / 2
		sw $t1, resultado		#resultado = $t1
		li $v0, 1
		lw $a0, resultado		#Imprimir resultado
		syscall
		j end				#Termina el programa

	esImpar:
		sll $t1, $s0, 2			#$t1 = $s0 * 4
		addi $t1, $t1, 1		#$t1 = 0 + 1
		
		sw $t1, resultado		#resultado = $t1
		li $v0, 1
		lw $a0, resultado		#Imprimir resultado
		syscall
		

	end:
		li $v0, 10
		syscall				#Fin programa
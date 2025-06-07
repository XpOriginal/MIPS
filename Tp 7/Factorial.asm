.data
	n:		.word 5
	resultado:	.word 0
	
.text
	main:	
		lw $a0, n		# Agarro el numero para el factorial (n!)
		jal factorial		# Llamo a la funcion factorial
		sw $v1, resultado	# resultado = factorial
		
		li $v0, 1
		lw $a0, resultado	# Imprimimos el resultado
		syscall
		
	# Finalizamos el programa
	li $v0, 10
	addi $a0, $v0, 0
	syscall
	
	factorial:
		addi $sp, $sp, -8	# Iniciamos la pila
		sw $s0, 0($sp)		# Cargamos s0 en la pila
		sw $ra, 4($sp)
		
		# Caso base
		li $v1, 1
		beq $a0, $zero, factorialTerminado	# if (i == 0) -> return 1
		
		# Else (i - 1)
		move $s0, $a0		# s0 = a0(El numero ingresado)	| Con esta linea guardamos a nuestro numero a multiplicar en nuestra pila
		sub $a0, $a0, 1		# (i - 1)
		
		jal factorial		# Recursividad
		
		# Multiplicamos nuestros numeros
		mul $v1, $s0, $v1	# return = s0 * v1(El numero que devuelve la recursividad)
		
		
		factorialTerminado:
			lw $s0, 0($sp)		# Recuperamos nuestro numero de la pila para futura ejecucion
			lw $ra, 4($sp)
			addi $sp, $sp, 8	# Reset pila
			
			jr $ra			# Fin de la funcion (Volvemos al main)
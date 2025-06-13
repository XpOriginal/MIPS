.data
	n: 	.word 5
.text
	main:
		lw $t0, n			# $t0 = n
		
		addi $sp, $sp, -4		# Lugar para el parametro de salida
		addi $sp, $sp, -4		# Lugar para el parametro de entrada
		sw $t0, 0($sp)			# Guardamos $t0 en la pila (En el parametro de entrada)
		
		jal calcular
		
		lw $t4, 0($sp)			# Guardamos en $t4 lo que esta en el parametro de salida de la pila
		addi $sp, $sp, 4		# Terminamos de borrar la lista
		
		li $v0, 1
		addi $a0, $t4, 0
		syscall
		
		#Fin del programa
		li $v0, 10
		syscall
		
	calcular:
		addi $sp, $sp, -4		# Espacio para la direccion de retorno
		sw $ra, 0($sp)			# Cargamos direccion de retorno
		addi $sp, $sp, -4		# Espacio para el frame pointer
		sw $fp, 0($sp)			# Guardamos el frame pointer antiguo
		addi $fp, $sp, 0		# Actualizamos el frame pointer
		
		lw $t3, 8($fp)			# Cargamos en t3 lo que esta 8 bits arriba del frame pointer ($t3 = Al primer parametro de entrada)
		andi $t1, $t3, 1		# Si el bit mas significativo es 1 es impar, si no es par
		beq $t1, $zero, esPar		# Chequea si es par o no es par, en caso de que sea salta hacia "esPar"
		j esImpar			# En caso de que sea impar, salta a "esImpar"
		
		esPar:
			srl $t3, $t3, 1		# $t3 = $t3/2
			sw $t3, 12($fp)		# Guardamos al resultado en el parametro de salida
			
			# Reset pila
			addi $sp, $fp, 0	# Volvemos a $sp al $fp
			lw $fp, 0($fp)		# Reiniciamos $fp, ahora apunta a otro lugar
			addi $sp, $sp, 4	# Nos movemos 4 bits hacia arriba
			lw $ra, 0($sp)		# Recuperamos la direccion de retorno
			addi $sp, $sp, 8	# Saltamos el parametro de entrada quedandonos en el parametro de salida
			
			jr $ra
		
		esImpar:
			sll $t3, $t3, 2
			addi $t3, $t3, 1
			sw $t3, 12($fp)		# Guardamos al resultado en el parametro de salida
			
			addi $sp, $fp, 0	# Volvemos a $sp al $fp
			lw $fp, 0($fp)		# Reiniciamos $fp, ahora apunta a otro lugar
			addi $sp, $sp, 4	# Nos movemos 4 bits hacia arriba
			lw $ra, 0($sp)		# Recuperamos la direccion de retorno
			addi $sp, $sp, 8	# Saltamos el parametro de entrada quedandonos en el parametro de salida
			
			jr $ra
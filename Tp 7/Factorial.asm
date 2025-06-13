.data
	n:		.word 7
	
.text
	main:
		lw $t1, n			# $t1 = n
		addi $sp, $sp, -4		# Lugar para el parametro de salida
		addi $sp, $sp, -4		# Lugar para el parametro de entrada
		sw $t1, 0($sp)			# Guardamos $t1 en la pila
		
		jal funcion			
		
		lw $t2, 0($sp)
		add $sp, $sp, 4
		
		li $v0, 1
		addi $a0, $t2, 0
		syscall
		
		#Fin del programa
		li $v0, 10
		syscall
	
	funcion:
		addi $sp, $sp, -4		# Lugar para la direccion de retorno
		sw $ra, 0($sp)			# Guardamos la direccion de retorno en la pila
		addi $sp, $sp, -4		# Lugar para el frame pointer
		sw $fp, 0($sp)			# Guardamos el frame pointer en la pila
		move $fp, $sp			# Actualizamos el frame pointer
		
		lw $t0, 8($fp)			# Cargamos en $t0 el parametro de entrada
		
		#Caso base
		bne $t0, $zero, recursion	# if $t0 != 0: Saltamos al caso recursivo
		addi $t1, $zero, 1		# else: $t0 = 1
		j retorno
	
	recursion:
		addi $t0, $t0, -1
		addi $sp, $sp, -4
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		
		jal funcion
		
		lw $t0, 0($sp)
		addi $sp, $sp, 4
		lw $t1, 8($fp)
		
		mul $t1, $t1, $t0
		
	retorno:
		sw $t1, 12($fp)
		addi $sp, $fp, 0	# Volvemos a $sp al $fp
		lw $fp, 0($fp)		# Reiniciamos $fp, ahora apunta a otro lugar
		addi $sp, $sp, 4	# Nos movemos 4 bits hacia arriba
		lw $ra, 0($sp)		# Recuperamos la direccion de retorno
		addi $sp, $sp, 8	# Saltamos el parametro de entrada quedandonos en el parametro de salida
		jr $ra
		
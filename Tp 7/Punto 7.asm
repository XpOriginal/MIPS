.data
	numeroASacar:		.word 4
	
	acceso:			.word nodo1
	
	nodo1:			.word 4
				.word nodo2
	
	nodo2:			.word 5
				.word nodo3
	
	nodo3:			.word 1
				.word nodo4
	
	nodo4:			.word 4
				.word 0		# NULL
	
	
.text
	main:
		lw $t1, numeroASacar
		lw $t2, acceso
		
		addi $sp, $sp, -4		# Lugar para el numero a sacar
		sw $t1, 0($sp)
		addi $sp, $sp, -4		# Lugar para el acceso
		sw $t2, 0($sp)
		
		jal funcionEliminar
	
	funcionEliminar:
		# Iniciamos la lista
		addi $sp, $sp, -8
		sw $ra, 4($sp)
		sw $fp, 0($sp)
		addi $fp, $sp, 0
		
		
		lw $t4, 12($fp)			# Agarramos el numero a sacar
		lw $t3, 8($fp)			# Agarramos el cursor (Acceso ahora)
		li $t5, 0			# Cursor auxiliar
		
		loop:
			beqz $t3, mostrar		# Si el cursor es 0, termino la lsita
			
			lw $s1, 0($t3)		# Guardamos el nodo en el que estamos (Para el Branch)
			
			beq $s1, $t4, borrar	# Si nuestro valor es igual al numero que queremos borrar, saltamos a borrar
			
			addi $t5, $t3, 0	# Movemos el cursor auxiliar al nodo actual
			lw $t3, 4($t3)		# Movemos el cursor al siguiente nodo
			j loop
			
		borrar:
			lw $s2, 4($t3)		# Guardamos el siguiente del cursor en un auxiliar
			
			beqz $t5, borrarPrimerNodo	# Chequeamos si al borrar es el primer nodo
			
			sw $s2, 4($t5)		# El siguiente del cursor auxiliar ahora es el siguiente del nodo actual (Eliminado)
			move $t3, $s2		# El cursor ahora apunta al siguiente nodo eliminado
			j loop
		
		borrarPrimerNodo:
			sw $s2, 8($fp)		# Como ya esta guardado el siguiente del cursor en $s2, actualizamos que el acceso (En la pila) apunte al nodo2
			move $t3, $s2		# El cursor ahora apunta al nodo2
			
			j loop
			
			
		mostrar:			#Mostrar la lista
    			lw $t3, 8($fp)		#Reseteamos la lista (Cargando el acceso desde la pila)
    		
    			imprimirLoop:			#Loop para imprimir 
    				beqz $t3, fin		#Fin de la lista
			
    				
    				li $v0, 1
    				lw $a0, 0($t3)
    				syscall
    			
    				lw $t3, 4($t3)
    				j imprimirLoop
	
	fin:
		addi $sp, $fp, 0
		lw $fp, 0($fp)
		addi $sp, $sp, 4
		lw $ra, 0($sp)
		addi $sp, $sp, 12
		
    		li $v0, 10
    		syscall

			
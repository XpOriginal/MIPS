.data
	acceso: 	.word nodo1
	
	nodo1:		.word 10
			.word nodo2
	
	nodo2:		.word 20
			.word nodo3
	
	nodo3:		.word 30
			.word nodo4
	
	nodo4:		.word 40
			.word 0			#NULL (Final de la lista)

.text
	main:
		li $t6, 0 		#ACUMULADOR = 0
		la $s1, acceso		#s1 ahora tiene la direccion de memoria de la lista (El acceso)
		lw $s1, 0($s1)		#s1 ahora tiene la direccion del nodo 1
	loop:
		beqz $s1, fin		#Si s1 (La direccion del nodo actual) es 0 (Null) Termina el programa
		
		lw $s0, 0($s1)		#s0 ahora tiene el valor del nodo actual (Guardado en s1)
		add $t6, $t6, $s0	#Acumulador = Acumulador + Nodo actual
			
		lw $s1, 4($s1)		#s1 va a tener la direccion del siguiente nodo (Next)
		j loop
	fin:
		li $v0, 1
		move $a0, $t6		#Imprimimos la suma
		syscall
		
		
		
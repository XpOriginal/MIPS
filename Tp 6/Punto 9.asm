.data
	letraASacar:	.byte 'a'

	acceso:		.word nodo1
	
	nodo1:		.byte 'a'	#El char que esta dentro del nodo (un byte)
			.space 3	#Los 3 bytes que faltan (4 bytes en total) para podernos mover entre nodos
			.word nodo2	#El puntero al siguiente nodo
	
	nodo2:		.byte 'b'
			.space 3
			.word nodo3
	
	nodo3:		.byte 'c'
			.space 3
			.word nodo4
	
	nodo4:		.byte 'd'
			.space 3
			.word 0		#NULL (FIN DE LA LISTA)
	
	salto:		.asciiz "\n"

.text
	main:
		lb $t6, letraASacar	#Aca guardamos la letra que vamos a usar para eliminar a un nodo
		la $t0, acceso		#t0 tiene la direccion de acceso
		lw $s1, 0($t0)		#s1 ahora tiene el valor de Nodo 1
		li $s2, 0 		#El anterior nodo a s1 (Empezando como null), parecido al cursor auxiliar de Prog 1
		
	loop:				#Se encarga de buscar al nodo que buscamos
		beqz $s1, fin

		lb $t1, 0($s1)		#Guardamos en t1 el char que esta en el nodo actual (s1)
		beq $t1, $t6, borrar	#Si t1 (Char del nodo) es igual al char que buscamos (t6) borramos
		
		move $s2, $s1		#Movemos el cursor auxiliar al nodo actual
		lw $s1, 4($s1)		#Movemos al nodo actual al siguiente
		j loop
	
	borrar:
		lw $t2, 4($s1)		#t2 ahora va a tener el siguiente del nodo actual
		
		beqz $s2, borrarPrimerNodo	#Si el cursor auxiliar es 0 (NULL), Significa que estamos borrando el primer nodo, por lo tanto modificamos el acceso
		
		sw $t2, 4($s2)		#El "siguiente" del cursor auxiliar ahora apunta al nodo actual
		move $s1, $t2		#s1 (Nodo borrado) = t2 (Nodo actual) | Ahora s1 vuelve a ser el nodo actual
		j mostrar
		
	borrarPrimerNodo:
		sw $t2, 0($t0)		#Decimos que acceso ahora apunta al segundo nodo, ya que no existe el primero
		move $s1, $t2		#Actualizamos al s1 (Nuestro cursor)
		j mostrar
	
	
	mostrar:			#Mostrar la lista
    		lw $s1, 0($t0)		#Reseteamos la lista
    		
    		imprimirLoop:			#Loop para imprimir 
    			beqz $s1, fin		#Fin de la lista
			
    			lb $a0, 0($s1)
    			li $v0, 11
    			syscall
    			
    			lw $s1, 4($s1)
    			j imprimirLoop
	
	fin:
    		li $v0, 4
    		la $a0, salto
    		syscall
.data
	arr:	.half 1,2,3,4,5		#arr = [1,2,3,4,5]
.text
	main:
		li $t0, 0		#INDICE = 0
		li $t1, 5		#LIMITE DEL FOR
		li $t3, 0		#ACUMULADOR
		la $t4, arr		#INDICE DEL ARREGLO
		
	loop:				#FOR
		bge $t0, $t1, fin	#(i=0;i<5;i++)
		lh $t2, 0($t4)		#t2 = arr[i]
		
		add $t3, $t3, $t2	#acumulador = acumulador + arr[i]
		addi $t0, $t0, 1	#i++
		addi $t4, $t4, 2	#Movemos el indice del arreglo
		j loop
	
	fin:
		li $v0, 1
		addi $a0, $t3, 0	#IMPRIME LA SUMA Y TERMINA EL PROGRAMA
		syscall
		
		
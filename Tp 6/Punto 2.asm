.data
	arr:	.space 400			#arr[100] (100*4 = 400)
.text
	main:
		addi $t0, $zero, 0		#indice = 0
		li $t1, 400			#limite = 100 (100*4 = 400)
		
		loop:				#for
			bge $t0, $t1, fin	#(i = 0; i < 100; i++)
			lw $t2, arr($t0)	#t2 = arr[i]
			bgtz $t2, if		#t2 > 0
			j else
			
			if: 
				subi $t2, $t2, 1	
				sw $t2, arr($t0)	#arr[i] = arr[i] - 1
				addi $t0, $t0, 4	#i++
				j loop
				
			else:
				addi $t2, $t2, 1
				sw $t2, arr($t0)	#arr[i] = arr[i] + 1
				addi $t0, $t0, 4	#i++
				j loop
		
	fin:
		li $v0, 10		#Termina el programa
		syscall
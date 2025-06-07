.data
	numero1:	.word 2
	numero2:	.word 5
.text
	main:
		addi $t0, $zero, 0		#indice = 0
		lw $t1, numero2($zero)		#limite
		lw $t2, numero1($zero)		#num 1
		addi $t3, $zero, 0		#acumulador = 0
		
		loop:				#for
			bge $t0, $t1, fin	#(i=0; i < numero2; i++)
			add $t3, $t3, $t2	#acumulador = acumulador + num 1
			addi $t0, $t0, 1	#i++
			j loop			#Volvemos al for
	
	fin:
		li $v0, 1
		add $a0, $t3, $zero		#imprimimos numero
		syscall
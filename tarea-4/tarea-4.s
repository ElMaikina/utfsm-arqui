@ Tarea 4: Arquitectura de Computadores

.global _start

@ Primera función (memoria) : Determinante de una matriz

@ Segunda función (subrutinas) : Ver si dos Strings son anagramas

@ Tercera (vectores) : Suma de vectores y càlculo de magnitud 

@ Datos suministrador por el enunciado
.data
	@ Funcion a ejecutar
	func: .word 1		

	@ Largo del primer string o del conjunto de la funcion 3
	len1: .word	7		
	
	@ Largo del segundo string
	len2: .word	0
	
	@ Conjunto numerico para las funciones 1 y 3
	nums: .word 0, 2, 7, 1, -8, -2, -8, 1, 4
	
	@ Primer string para la funcion 2
	str1: .asciz "dato"
	
	@ Segundo string para la funcion 2
	str2: .asciz "toda"		

.text

@ Aquí parte el código
_start:
	@ Define el registro para determinar
	@ la operación a usar
	LDR r0, =func
	LDR r0, [r0, #0]

	@ Revisa si la función es la primera
	CMP r0, #1
	BEQ funcionuno

	@ Revisa si la función es la segunda
	CMP r0, #2
	BEQ funciondos
	
	@ Revisa si la función es la tercera
	CMP r0, #3
	BEQ funciontres

	CONTINUE:
	B end


@ Primera función (memoria) : Determinante de una matriz
funcionuno:
	@ Carga la matriz en memoria como un arreglo
	LDR r1, =nums

	@ Definimos la determinante de la siguiente forma
	@ DET = A - B
	@ Donde
	@	A = Suma de las diagonales negativas
	@	B = Suma de las diagonales positivas

	@ (Determinante por metodo de Sarruss)

	@ Valor final del Determinante
	MOV r5, #0	
	
	@ Suma de las diagonales negativas
	LDR r2, [r1, #0]
	LDR r3, [r1, #16]	
	LDR r4, [r1, #32]
	MUL r2, r2, r3
	MUL r2, r2, r4
	ADD r5, r5, r2	

	LDR r2, [r1, #4]
	LDR r3, [r1, #20]
	LDR r4, [r1, #24]
	MUL r2, r2, r3
	MUL r2, r2, r4
	ADD r5, r5, r2	

	LDR r2, [r1, #8]
	LDR r3, [r1, #12]
	LDR r4, [r1, #28]
	MUL r2, r2, r3
	MUL r2, r2, r4
	ADD r5, r5, r2

	@ Suma de las diagonales positivas
	LDR r2, [r1, #8]
	LDR r3, [r1, #16]	
	LDR r4, [r1, #24]
	MUL r2, r2, r3
	MUL r2, r2, r4
	SUB r5, r5, r2	

	LDR r2, [r1, #4]
	LDR r3, [r1, #12]
	LDR r4, [r1, #32]
	MUL r2, r2, r3
	MUL r2, r2, r4
	SUB r5, r5, r2	

	LDR r2, [r1, #0]
	LDR r3, [r1, #20]
	LDR r4, [r1, #28]
	MUL r2, r2, r3
	MUL r2, r2, r4
	SUB r5, r5, r2	
	
	B CONTINUE

@ Segunda función (subrutinas) : Ver si dos Strings son anagramas
funciondos:
	
	LDR r1, =str1
	LDR r2, =str2
	B CONTINUE


@ Tercera (vectores) : Suma de vectores y càlculo de magnitud 
funciontres:
	@ Carga el arreglo en memoria
	LDR r1, =nums

	@ Carga el largo en memoria
	LDR r2, =len1
	LDR r2, [r2, #0]

	@ Carga el primer elemento del arreglo
	LDR r3, [r1, #0]

	@ Indice del arreglo
	MOV r4, #0

	@ Coordenada eje X
	MOV r5, #0
	@ Coordenada eje Y
	MOV r6, #0

	@ Multiplica el largo por 4
	LSL r2, r2, #2

	FOR:
		@ Primero la coordenada X

		@ Verifica que el indice
		@ sea menor al largo
		CMP r4, r2
		BEQ DONE
		
		@ Carga el i-esimo
		@ valor en memoria
		LDR r3, [r1, r4]

		@ Suma el movimiento a X
		ADD r5, r5, r3
		
		@ Avanza el indice
		ADD r4, r4, #4


		@ Segundo la coordenada Y

		@ Verifica que el indice
		@ sea menor al largo
		CMP r4, r2
		BEQ DONE
		
		@ Carga el i-esimo
		@ valor en memoria
		LDR r3, [r1, r4]

		@ Suma el movimiento a X
		ADD r6, r6, r3
		
		@ Avanza el indice
		ADD r4, r4, #4

		B FOR
	
	DONE:

	B CONTINUE

square:

root:

end:

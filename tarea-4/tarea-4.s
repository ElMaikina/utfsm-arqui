@ Tarea 4: Arquitectura de Computadores

.global _start

@ Primera función (memoria) : Determinante de una matriz

@ Segunda función (subrutinas) : Ver si dos Strings son anagramas

@ Tercera (vectores) : Suma de vectores y càlculo de magnitud 

@ Datos suministrador por el enunciado
.data
	@ Funcion a ejecutar
	func: .word 3

	@ Largo del primer string o del conjunto de la funcion 3
	len1: .word	6	
	
	@ Largo del segundo string
	len2: .word	4
	
	@ Conjunto numerico para las funciones 1 y 3
	nums: .word 0, 2, 7, 1, -8, -2, -8
	
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
	
	MOV r0, #0
	MOV r1, #0
	MOV r2, r5
	bl printInt

	B end

@ Segunda función (subrutinas) : Ver si dos Strings son anagramas
funciondos:
	@ Carga el primer largo en memoria
	LDR r1, =len1
	LDR r1, [r1, #0]
	
	@ Carga el segundo largo en memoria
	LDR r2, =len2
	LDR r2, [r2, #0]

	@ Salta a la funcion anagrama
	B anag

	B end

@ Retorna 1 si los dos strings son anagramas
anag:
	@ Inicializa un vector vacio
	MOV r0, #0

	@ Compara si los largos son iguales
	@ se asume que los largos siempre
	@ están bien puestos
	CMP r1, r2
	BEQ anagtrue
	B anagfalse

@ La funcion retorna false y termina
anagfalse:
	B end

@ La funcion retorna true y sigue
anagtrue:
	@ Nuestro índice para leer el str1
	MOV r1, #0

	anagloop:
		@ Carga el primer string
		MOV r3, #0
		LDR r3, =str1

		@ Revisa si el indice es menor al largo del string
		CMP r1, r2
		BEQ anagdone

		@ Carga el siguiente caracter
		LDRB r4, [r3, r1]

		@ Avanza el índice
		ADD r1, r1, #1

		@ Desplaza el vector a la izquierda
		LSL r0, r0, #4

		@ Salta a la funcion vect
		B vect		

		B anagloop
	anagdone:

	B end


@ Retorna 2 si los dos vectores son iguales
vect:
	@ Carga el segundo string
	MOV r3, #0
	LDR r3, =str2

	@ Nuestro índice para leer el str2
	MOV r6, #0

	vectloop:
		@ Carga el segundo string
		MOV r3, #0
		LDR r3, =str2

		@ Revisa si el indice es menor al largo del string
		CMP r6, r2
		BEQ vectdone

		@ Carga el siguiente caracter
		LDRB r5, [r3, r6]

		@ Avanza el índice
		ADD r6, r6, #1

		@ Salta a cont
		B cont

		B vectloop
	vectdone:

	B anagloop


@ Cuenta la cantidad de veces que se repite un caracter
@ retorna un vector con las cantidades
cont:
	@ Usamos el registro r0 como vector
	@ cada posición de r0 indica la
	@ repeticion de ese caracter
	CMP r4, r5

	@ Si los registros r4 y r5 son iguales
	@ entonces va a la branch contadd
	BEQ contadd
	
	@ Se devuelve a la branch original
	@ independiente del resultado
	B vectloop 
	
@ Suma al vector si es que los caracteres son iguales
contadd:
	ADD r0, r0, #1
	B vectloop

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

		@ Suma el movimiento a Y
		ADD r6, r6, r3
		
		@ Avanza el indice
		ADD r4, r4, #4

		B FOR
	
	DONE:

	@ Eleva X al cuadrado
	MUL r5, r5, r5

	@ Eleva Y al cuadrado
	MUL r6, r6, r6

	@ Guarda la suma de X e Y
	@ al cuadrado
	MOV r2, #0
	ADD r2, r5, r6

	@ Inicia la raiz
	MOV r3, #1

	WHILE:
		@ Almacena la potencia de
		@ la raiz
		MOV r4, #0
		ADD r4, r4, r3
		MUL r4, r4, r4

		CMP r4, r2

		@ Si la raiz al cuadrado
		@ es mayor a la potencia
		@ entonces encontramos la
		@ raiz
		BGT EXIT

		@ Agrega 1 a la raiz y
		@ repite el loop
		ADD r3, #1

		B WHILE
	EXIT:

	@ Le resta 1 a la raiz ya que
	@ queremos que trunque el valor
	@ al entero mas cercano

	@ Finalmente el valor de la magnitud
	@ del vector queda en r3
	SUB r3, r3, #1

	MOV r0, #0
	MOV r1, #0
	MOV r2, r3
	bl printInt

	B end


end:

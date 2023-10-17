; --------------------------------------------------------
; Suma de números en posiciones impares en un arreglo de enteros.

; El programa debe recibir un arreglo de enteros (puede estar predefinido)
; y suma los números de éste que estén almacenados en posiciones (índices) impares.
; Imprime el resultado en pantalla.
; --------------------------------------------------------

include c:\masm32\include\masm32rt.inc
	
.data
	; array DWORD 79
    ; array DWORD 1, -2, -3, 4, 5, 6, -7, -8, 9, 10
    ; array DWORD -1, -2, -3, -4, -5, -6, -7, -8, -9, -10
    array DWORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	last_array_index DWORD 0
	sum DWORD 0

.code
start:  
    call main
    exit

	main proc
		; Iterador establecido en 0
		xor ESI, ESI

		; Comienzo del formato del arreglo
		print chr$("Arreglo: [")

		; Calcular el ultimo indice del arreglo
		mov ECX, LENGTHOF array
		dec ECX
		mov last_array_index, ECX

		.while (ESI <= last_array_index)
			; Ya que el arreglo es de tipo DWORD, debe iterarse en pasos de 4 bytes
			mov EAX, array[ESI * 4]

			; Realiza una operación AND con 1 (Prueba de paridad)
			test ESI, 01h
			; Si el resultado es distinto de 0, el número es impar
			; Nota: Esto es conveniente ya que los indices son positivos
			; Si se quisiera comprobar con numeros negativos,
			;  se deberia comprobar el bit menos significativo
			;  con un registro mas pequeño (por ejemplo AL)

			; Aunque el indice empieza desde 0, la posicion actual es 1
			; Por tanto, la sumatoria sera cuando el indice sea par
			jz perform_addition

			; Cuando el indice es impar (posicion par),
			; ignorar el elemento y continuar iterando
			jnz continue_iteration

			perform_addition:
				; Acumula en sum el valor del elemento actual (EAX)
				add sum, EAX

			continue_iteration:	
				; Imprime el elemento actual del arreglo
				print str$(array[ESI * 4])

				; Al llegar al ultimo elemento, salta al cierre del formato
				cmp ESI, last_array_index
				je array_formatting_end

				; Imprime una coma mientras el elemento no sea el ultimo
				print chr$(", ")

				; Incrementa el contador
				inc ESI
		.endw

		array_formatting_end:
			; Cierre del formato del arreglo
			print chr$("]", 10, 10)

		print chr$("Sumatoria: ")
		print str$(sum)
		print chr$(10, 10) ; Doble salto de linea

		ret
	main endp
end start

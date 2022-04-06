;; Name: Oluwatope Alofe (20671736)
;; Quest: oealofe

;; This program reverses the contents of the array located in register $1
;; with its length in register $2
;; Registers:
;;	$1 -> contains array location
;;	$2 -> contains length of array in register $1
;; 	$3, $4 -> used as needed

	add $3, $0, $2		; register $3 has length of array
loop:	beq $2, $0, back	; if array empty, jump to reverse
	lw $4, 0($1)		; store current element in array in register $4
	addi $1, $1, 4		; move to next element in array
	addi $30, $30, -4	; decrement stack pointer
	sw $4, 0($30)		; store element in register $4 in stack
	addi $2, $2, -1		; decrease length of array by 1
	beq $0, $0, loop

back:	add $2, $0, $3		; restore length of array to $2
	addi $4, $0, 4
	mult $2, $4
	mflo $4			; register $4 has distance from array pointer to original array location
	sub $1, $1, $4		; array pointer moves back to orginal array location

append:	beq $3, $0, end		; if no more elements left to append, jump to end label
	addi $3, $3, -1
	lw $4, 0($30)		; load current element in stack to register $4
	addi $30, $30, 4	; move stack pointer to next element in stack
	sw $4, 0($1)		; save element in register $4 to array location in $1
	addi $1, $1, 4		; move to next element in array
	beq $0, $0, append

end:	addi $4, $0, 4
	mult $2, $4
	mflo $4			; find distance between array pointer and original array location
	sub $1, $1, $4		; move array pointer back to original array location
	jr $31

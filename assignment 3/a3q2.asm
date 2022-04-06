;; This program calculates the value of y in the equation y = (4a + 3b)^2 + 5(a - b) - 1
;; and places the result in register $3, assuming the values for a and b are in registers
;; $1 and $2 respectively
;; Registers:
;;	$1 -> stores the value of a
;;	$2 -> stores the value of b
;;	$3 -> stores the calculated value of y

	addi $4, $0, 4		; store 4 in $4
	mult $4, $1		; multiply 4 by a
	mflo $3			; move the 4*a to $3
	addi $4, $0, 3		; store 3 in $4
	mult $4, $2		; multiply 3 by b
	mflo $4			; move 3*b to $4
	add $3, $3, $4		; add 4*a and 3*b
	mult $3, $3		; square (4*a + 3*b)
	mflo $3			; store (4*a + 3*b)^2 in $3
	addi $4, $0, 5		; store 5 in $4
	sub $5, $1, $2		; store a-b in $5
	mult $4, $5		; multiply 5 by (a-b)
	mflo $4			; store 5*(a-b) in $4
	add $3, $3, $4		; add 5*(a-b) to (4*a + 3*b)^2 in $3
	addi $3, $3, -1		; remove 1 from 5*(a-b) + (4*a + 3*b)^2 in $3
	jr $31

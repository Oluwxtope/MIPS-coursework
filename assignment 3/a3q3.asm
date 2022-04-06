;; This program will calculate the number of times a positive integer between 1 and 9 inclusive
;; stored in register $2 appears in register $1, place the value in register $3
;; Registers:
;;	$1 -> stores a non-negative integer
;;	$2 -> stores  a positive integer between 1 and 9
;; 	$3 -> stores the number of times the digit in $2 appears in the number in register $1
;;	$4 -> stores the number 10
;;	$5 -> stores remainders used in division

	add $3, $0, $0		; start off register $3 with 0
	addi $4, $0, 10		; store 10 in register $4

loop:	beq $1, $0, end		; if or when the number in register $1 = 0, end program
	div $1, $4		; divide number in register $1 by 10 in register $4
	mfhi $5			; store the remainder in register $5
	mflo $1			; move quotient from division to register $1
	bne $5, $2, loop	; checks if the remainder in register equals the digit in $2
	addi $3, $3, 1		; will run if the digit in register $2 is equal to the remainder in register $5 and add 1 to register $3
	beq $0, $0, loop	; goes to loop again

end:	jr $31

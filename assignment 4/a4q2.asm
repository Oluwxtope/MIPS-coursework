;; Name: Oluwatope Alofe (20671736)
;; Quest: oealofe

;; An array with non-negative integers is located in register $1, and represents all digits of a credit card
;; except its check digit. This program calculates the check digit of the array using Luhn's algorithm
;; and stores it in register $3. The length of the array is stored in register $2.
;; Registers:
;;	$1 -> stores location of the array
;;	$2 -> stores length of the array
;;	$3 -> stores check digit of array
;;	$4 - $6 -> used as needed

	addi $3, $0, 4
	mult $2, $3
	mflo $3
	add $1, $1, $3		; takes array pointer in register $1 to end of array

	add $3, $0, $0		; register $3 will store sum of digits
	add $4, $0, $0		; register $4 counts loop iterations

loop:	beq $2, $0, end
	addi $1, $1, -4         ; moves to previous element in array
	lw $5, 0($1)		; register $5 contains current element in array
	addi $4, $4, 1		; increase iteration counter by 1
	addi $2, $2, -1		; decreases length of array

	addi $6, $0, 2		; uses register $6 to store constant 2
	div $4, $6
	mfhi $6			; if odd elements from check digit, will contain 1. otherwise will contain 0
	addi $6, $6, 1		; if odd, will turn to 2; otherwise will turn to 1
	mult $5, $6		; double content in register $5 if odd, otherwise remains as is
	mflo $5

	addi $6, $0, 10		; uses register $6 to store constant 10
digits:	div $5, $6		; divides register $6 by 10 to get last digit
	mfhi $5
	add $3, $3, $5		; adds last digit to sum of digits
	mflo $5			; gets quotient from division if any
	bne $5, $0, digits	; if additional digits are present, loops to add them
	beq $0, $0, loop	; continues with next element in array

end:	add $2, $0, $4		; sets register $2 to length of array
	addi $4, $0, 9		; initializes register $4 to contain 9
	addi $5, $0, 10		; initializes register $5 to contain 10
	mult $3, $4		; multiply sum of digits by 9
	mflo $3
	div $3, $5		; divide sum of digits * 9 by 10
	mfhi $3
	jr $31

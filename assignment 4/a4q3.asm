;; Name: Oluwatope Alofe (20671736)
;; Quest: oealofe

;; This program reads a single line of input assuming the characters are indexed starting from position 0.
;; It takes in two integers and stores them in registers $1, and $2. If both registers are valid indices
;; of the string input, and $1 <= $2, it prints out the characters from index position in $1 up to, but
;; not including the character in index position $2, and sets register $3 to 0. If both registers are valid,
;; and $1 = $2, it prints a newline character alone and sets register $3 to 1. If either register is invalid,
;; and $1 <= $2, nothing is printed and it sets $3 to 2. If either register is invalid, and $1 > $2, nothing
;; is printed and $3 is set to 3.
;; Registers:
;;	$1, $2 -> contain integers
;;	$3 -> contains result of running program according to above rules
;;	$4 -> contains input address
;;	$5 -> contains output address
;;	$6 -> contains ascii code for newline character
;;	$7 - $10 -> used as needed

	lis $4			; register $4 contains input address
	.word 0xFFFF0004
	lis $5			; register $5 contains output address
	.word 0xFFFF000C
	addi $6, $0, 0xA	; register $6 contains ascii code for newline char

	add $7, $0, $0		; register $7 contains iteration counter

in:	lw $8, 0($4)		; register $8 contains input
	beq $8, $6, check	; if input is newline char, move to check label
	addi $7, $7, 1
	addi $30, $30, -4
	sw $8, 0($30)
	beq $0, $0, in

check:	slt $9, $7, $2		; checks if index in register $2 is less than or equal to string length
	slt $10, $7, $1		; checks if index in register $1 is less than or equal to string length
	bne $0, $9, inv		; if index in register $2 invalid, move to inv label
	bne $0, $10, inv	; if index in register $1 invalid, move to inv label
	slt $9, $2, $0		; checks if index in register $2 is less than 0
	slt $10, $1, $0		; checks if index in register $1 is less than 0
	bne $0, $9, inv         ; if index in register $2 invalid, move to inv label
        bne $0, $10, inv        ; if index in register $1 invalid, move to inv label

	slt $9, $2, $1		; checks if register $2 < $1
	add $3, $0, $9		; if $1 > $2, $3 would be 1. else it will be 0
	bne $3, $0, stack	; if $3 not equal to 0, clean stack
	beq $1, $2, newl	; if $1 = $2, will print new line character

prep:	addi $8, $7, -1		; register $8 set to index of last element in stack
	addi $7, $2, 1		; register $7 contains distance between last element and original stack pointer
	sub $9, $8, $1		; register $9 measures elements between last element and element in index $1
	addi $10, $0, 4
	mult $9, $10		; distance between stack pointer and element in index $1 * 4
	mflo $9
	add $30, $30, $9	; go to element in index $1
	sub $9, $2, $1		; register $9 stores number of elements between $1 and $2 indices, element in $2 not included

out:	lw $8, 0($30)		; load current element in stack to $8
	sw $8, 0($5)		; print element in $8 to screen
	addi $9, $9, -1
	addi $30, $30, -4
	bne $0, $9, out

newl:	sw $6, 0($5)		; print new line char
	beq $0, $0, stack

inv:	addi $3, $0, 2
	slt $9, $2, $1		; if $1 > $2, sets $9 to 1. otherwise $9 is 0
	add $3, $3, $9		; if $1 > $2, $3 will equal 3. otherwise, it will remain $2

stack:	addi $8, $0, 4
	mult $8, $7
	mflo $8			; register $10 contains distance between original position of stack pointer and current
	add $30, $30, $8	; moves stack pointer to original location

end:	jr $31

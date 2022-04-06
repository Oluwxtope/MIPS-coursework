;; Name: Oluwatope Alofe (20671736)
; QuestID: oealofe

;; This program is a subroutine that takes in the address of a subroutine with one parameter,
;; the address of the first element of an array, and the size of an array in that order, and
;; creates a copy of the elements of the original array that cause the filtering function to
;; produce 1 (interpreted as true). The program also returns the address of the first element
;; of the newly created array, and the size of the newly created array, in that order
;; Registers:
;;	$4 -> contains address of function
;;	$5 -> contains address of first element of array
;;	$6 -> contains size of array
;;	$2 -> contains address of first element of new array
;;	$3 -> contains size of new array
;;	$8 -> 4
;;	$9 -> used as temp
;;	$16 -> copy of $4

filter:
	addi $30, $30, -4
	sw $16, 0($30)		; store $16 original element to stack
	add $16, $0, $4 	; store $4 in $16
	add $3, $0, $0		; sets up size of new array
	addi $8, $0, 4		; $8 = 4
	mult $6, $8
	mflo $8
	add $2, $0, $8		; $2 is the address of first element after array in $5
	add $10, $2, $0
loop:	beq $0, $6, end		; if $6 = 0, end the subroutine
	addi $30, $30, -20
	sw $2, 0($30)		; store address of new array to stack
	sw $10, 4($30)
	sw $3, 8($30)		; store size of new array to stack
	sw $5, 12($30)		; store address of first element of array
	sw $6, 16($30)		; store size of array
	lw $4, 0($5)		; load element in $5 into $4
	addi $30, $30, -4
	sw $31, 0($30)
	jalr $16
	lw $31, 0($30)		; restore contents of register $31
	addi $30, $30, 4
	add $8, $2, $0		; save contents of returned $2 to $8
	lw $2, 0($30)
	lw $10, 4($30)
	lw $3, 8($30)
	lw $5, 12($30)
	lw $6, 16($30)
	addi $30, $30, 20
	lw $9, 0($5)		; load element in $5 into $9
	addi $5, $5, 4		; move to next element in original array in $5
	addi $6, $6, -1		; decrease length of original array by 1 in $6
	beq $8, $0, loop	; if $16 function returns 1, jump to save
save:	sw $9, 0($10)
	addi $10, $10, 4	; move array pointer in $2 to next space
	addi $3, $3, 1          ; add 1 to length of new array in $4
	beq $0, $0, loop
end:	lw $16, 0($30)
	addi $30, $30, 4
	jr $31

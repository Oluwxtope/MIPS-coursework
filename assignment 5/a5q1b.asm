;; Name: Oluwatope Alofe (20671737)
;; QuestID: oealofe

;; This program uses the filter subroutine to create a new array that is a subset of the original
;; Registers:
;;	$1 -> stores address of first element
;;	$2 -> stores result of ascii subroutine
;;	$4 -> stores ascii label
;;	$5 -> address of array
;;	$6 -> length of array
;;	$8, $9 -> temp


	lis $4
	.word ascii
	add $5, $0, $1
	add $6, $0, $2
	addi $30, $30, -4
	sw $31, 0($30)
	jal filter
	lw $31, 0($30)
	addi $30, $30, 4
	add $1, $2, $0
	add $2, $3, $0
	jr $31

ascii:
	add $2, $0, $0
	addi $8, $0, -1
	addi $9, $0, 256
	slt $2, $8, $4
	beq $0, $2, endof
	slt $2, $4, $9
endof:	jr $31

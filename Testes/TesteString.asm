	.data
vetor_xy: .word 1,2
vetor_xy_1: .word 4,5
vetor_xy_2: .word 8,9
buffer: .space 4
	.text
main:
	la a2, vetor_xy
	jal string_tupla2
	la a0, buffer
	li a7, 4
	ecall
	
	li a7, 10
	ecall
.include "../StringFunctions.asm"
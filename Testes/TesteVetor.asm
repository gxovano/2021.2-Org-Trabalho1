	.data
.align 2
vetor_acertos: .space 100
vetor_xy: .word 1,2
vetor_xy_1: .word 4,5
vetor_xy_2: .word 8,9

	.text
main:
	la a4, vetor_acertos
	la a5, vetor_xy
	jal insere_tupla2_vetor
	la a5, vetor_xy_1
	jal insere_tupla2_vetor
	la a5, vetor_xy_2
	jal insere_tupla2_vetor
	jal ultimo_elemento_vetor
	#fim
	li a7, 10
	ecall
	
.include "../VectorFunctions.asm"
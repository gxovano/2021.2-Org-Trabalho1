	.data
nro_linhas: .byte 5
nro_colunas: .byte 5
matriz: .word 0

	.text
main:
	la a1, matriz
	li a2, 255
	li a3, 2
	li a4, 4
	la t0, insere_matriz
	jalr t0
	la a1, matriz
	li a2, 2
	li a3, 4
	la t0, busca_matriz
	jalr t0
	li a7, 93
	ecall

	.include "strings.asm"
	

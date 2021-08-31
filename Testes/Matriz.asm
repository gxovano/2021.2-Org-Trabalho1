	.data
nro_linhas: .byte 5
nro_colunas: .byte 5
matriz: .word 0

	.text
main:
	la a2, matriz
	li a3, 255
	li a4, 2
	li a5, 4
	la t0, insere_matriz
	jalr t0
	la a2, matriz
	li a3, 2
	li a4, 4
	la t0, busca_matriz
	jalr t0
	li a7, 93
	ecall

	.include "strings.asm"
	

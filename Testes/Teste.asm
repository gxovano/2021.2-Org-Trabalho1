	.data
ordem: .word 9
vetor: .word 0, 3, 0, 4
matriz: .word 2, 

	.text
main:
	la a2, vetor
	la a3, matriz
	jal insere_embarcacao
	li a7, 93
	ecall
	
insere_embarcacao:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal testeAB_vetor
	jal teste_sobreposicao
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.include "TestesEmbarcacao.asm"

teste_sobreposicao:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal gerar_vetor_logico
	addi s0, a0, 0
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

#####
 # gerar_vetor_logico(a2): gera vetor de bits representando o navio
 #  O MSB do vetor de bits é a posição de início (coordenada inicial vertical ou horizontal)
 #      a2: ponteiro do vetor representando o navio
 #	-> a0: vetor de bits
gerar_vetor_logico:
	li t0, 1
	li t1, 1
	lw t2, 4(a2)
loop_gerador:
	slli t1, t1, 1
	addi t1, t1, 1
	addi t0, t0, 1
	bne t0, t2, loop_gerador
	li t2, 10			# ordem da matriz
	lw t3, 4(a2)			# tamanho do navio
	lw t4, 0(a2)
	beqz t4, ajusta_horizontal
	bnez t4, ajusta_vertical
ajusta_horizontal:
	lw t4, 8(a2)	
	j alinha_vetor
ajusta_vertical:	
	lw t4, 12(a2)
alinha_vetor:
	sub t5, t2, t3			# m - b
	sub t5, t5, t4 			# m - b - MSB
	sll a0, t1, t5
	ret
	
	

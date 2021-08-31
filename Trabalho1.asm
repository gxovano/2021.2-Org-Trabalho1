	.data
.include "PromptTexts.asm"
ordem: .word 10
vetor_v: .word 0, 0, 0, 0
matriz: .word 0

	.text
main:
	jal prompt_usuario
	ebreak
	la a2, vetor_v	
	
	la a3, matriz 
	jal insere_embarcacoes
	
	addi a2, a0, 0
	#jal mostra_erro
	# fim
	li a7, 93
	ecall

.include "PromptFunctions.asm"
			
#####
 # insere_embarcacoes(a2,a3): insere a embarcação na matriz
 #      a2: ponteiro do vetor representando o navio
 #	a3: ponteiro do início da matriz
 #       0(a2): disposicao do navio (0 horizontal) (1 vertical)
 #       4(a2): comprimento do navio 
 #       8(a2): linha inicial do navio
 #      12(a2): coluna inicial do navio 
insere_embarcacoes:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal testeAB_vetor
	bnez a0, fim
	#jal teste_sobreposicao
	ebreak
	addi a4, a3, 0
	addi a4, a4, 4
	lw a6, 0(a3)				# números de linhas na matriz
	addi s0, a2, 0				# contador de elementos do vetor
	li t2, 0				# contador de colunas
	addi a7, t2, 0
	li t4, 4				# número de colunas da matriz de navios
loop_insere:
	lw a5, 0(s0)
	jal insere_matriz_embarcacoes
	addi s0, s0, 4
	addi a7, a7, 1
	bne a7, t4, loop_insere
	addi a6, a6, 1
	sw a6, 0(a3)
fim:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	

.include "InsertionFunctions.asm"
.include "InsertionTests.asm"
	
	

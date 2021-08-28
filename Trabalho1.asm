	.data
.include "PromptTexts.asm"
ordem: .word 10
vetor1: .word 0, 0, 0, 0
matriz: .word 0
#matriz: .word 1, 0, 3, 3, 3 

	.text
main:
	jal prompt_usuario
	
	la a2, matriz 
	la a3, vetor1	
	jal insere_embarcacoes
	
	# fim
	li a7, 93
	ecall

.include "PromptFunctions.asm"
			
#####
 # insere_embarcacoes(a2,a3): insere a embarcação na matriz
 #      a2: ponteiro do inicio da matriz
 #	a3: ponteiro do vetor representando o navio
 #       0(a2): disposicao do navio (0 horizontal) (1 vertical)
 #       4(a2): comprimento do navio 
 #       8(a2): linha inicial do navio
 #      12(a2): coluna inicial do navio 
insere_embarcacoes:
	lw t1,0(a2)
	beqz t1, insere
insere:
	li t2, 4
	mul t1, t1, t2
	
		 
	ret
	
#.include "InsertionTests.asm"
	
	
	

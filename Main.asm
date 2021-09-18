	.data
.include "PromptTexts.asm"
preenchimento1: .word 0x2d
preenchimento2: .word 0x2e
inicio_maiusculas: .word 0x41
ordem: .word 10
matriz_posicoes: .space 100 
matriz_tiros: .space 100 
vetor_de_tiros: .space 100 
#matriz_embarcacoes: .space 400 
string_embarcacoes: .asciz "3\n1 5 0 0\n0 3 2 2\n1 1 3 4" 
matriz_embarcacoes: .word 3, 1, 5, 0, 0, 0, 3, 2, 2, 1, 1, 3, 4
vetor_tiros_acertados: .space 100 
vetor_tiros_errados: .space 100 
#vetor_tiros_acertados: .word 4, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4
#vetor_tiros_errados: .word 4, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4

	.text
main:	
	la a2, string_embarcacoes		# carrega endereço do string de embarcações
	la a3, matriz_embarcacoes		# carrega endereço da matriz de embarcações
	la a4, matriz_posicoes			# carrega endereço da matriz de caracteres de posições
	la a5, matriz_tiros			# carrega endereço da matriz de caracteres de tiros
	jal inicio_do_jogo			# inicializa o conteúdo das matrizes
loop_jogo:					# loop de interação principal do jogo
	la a2, matriz_tiros			# carrega endereço da matriz de caracteres de tiros
	la a3, menu				# carrega endereço do menu a ser exibido para o usuário
	la a4, menu_footer			# carrega endereço do rodapé
	jal menu_e_tiros			# exibe opções para o usuário
	li t0, 5				# carrega número 5 para comparação
	beq a0, t0, fim_jogo			# caso opção digitada for 5, encerra jogo
	li t0, 1				# carrega número 1 para comparação
	li t0, 2				# carrega número 2 para comparação
	li t0, 3				# carrega número 3 para comparação
	li t0, 4				# carrega número 4 para comparação
fim_jogo:
	li a7, 10
	ecall
	
.include "PromptFunctions.asm"		
.include "MatrixFunctions.asm"
.include "CharMatrixFunctions.asm"

#####
 # inicio_do_jogo(a2,a3,a4,a5): inicialização do jogo
 #      a2: ponteiro para string representando a matriz de embarcações
 #      a3: ponteiro para matriz de embarcações
 #      a4: ponteiro para matriz de caracteres de posições
 #      a5: ponteiro para matriz de caracteres de tiros
inicio_do_jogo:
	addi sp, sp, -20
	sw ra, 0(sp)
	sw a2, 4(sp)				# salva valor de A2 na pilha para chamada de função 
	sw a3, 8(sp)				# salva valor de A3 na pilha para chamada de função
	sw a4, 12(sp)				# salva valor de A4 na pilha para chamada de função
	sw a5, 16(sp)				# salva valor de A5 na pilha para chamada de função
	#TODO conversão da string de navios para a matriz de embarcações
	addi a3, a4, 0				# carrega a2 para chamada de função
	jal gera_matriz_vazia			# 
	lw a2, 8(sp)				# carrega input a3 para chamada de função
	lw a3, 12(sp)				# carrega input a4 para chamada de função
	jal gera_matriz_posicoes		# 
	lw a3, 16(sp)				# 
	jal gera_matriz_vazia			# 
	lw ra, 0(sp)				# 
	addi sp, sp, 20				# 
	ret

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
	
.include "InsertionTests.asm"
	
	

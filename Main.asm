	.data
.include "PromptTexts.asm"
preenchimento1: .word 0x2d 			# código ASCII '-'
char_tiro_certeiro: .word 0x78			# código ASCII 'x'
char_tiro_nagua: .word 0x6f			# código ASCII 'o'
inicio_maiusculas: .word 0x41
ordem: .word 10
vetor_xy: .word 0, 0
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
	la a0, separador_prompt		# caracteres para separação de rodadas de output do prompt
	li a7, 4				# carrega código ecall PrintString
	ecall					#
	la a2, matriz_tiros			# carrega endereço da matriz de caracteres de tiros
	la a3, menu				# carrega endereço do menu a ser exibido para o usuário
	la a4, menu_footer			# carrega endereço do rodapé
	jal menu_e_tiros			# exibe opções para o usuário
	li t0, 6				# carrega número 5 para comparação
	beq a0, t0, fim_jogo			# caso opção digitada for 5, encerra jogo
	li t0, 1				# carrega número 1 para comparação
	beq a0, t0, exibe_matriz_navios	# caso opção digitada for 1, exibe a matriz de navios
	li t0, 2				# carrega número 2 para comparação
	beq a0, t0, input_tiro			# caso opção digitada for 2, solicita ao usuário coordenadas de tiro
	li t0, 3				# carrega número 3 para comparação
	li t0, 4				# carrega número 4 para comparação
	li t0, 5				# carrega número 6 para comparação
	beq a0, t0, reiniciar			# reinicializa as matrizes
	j loop_jogo				# continua o loop do jogo
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
	lw a3, 12(sp)				# carrega ponteiro da matriz de caracteres de posições
	jal gera_matriz_vazia			# insere caracteres de preenchimento na matriz
	lw a3, 16(sp)				# carrega ponteiro da matriz de caracteres de tiros
	jal gera_matriz_vazia			# insere caracteres de preenchimento na matriz
	lw a2, 8(sp)				# carrega ponteiro da matriz de embarcações
	lw a3, 12(sp)				# carrega ponteiro da matriz de caracteres de navios
	jal gera_matriz_posicoes		# insere navios na matriz de navios
	lw ra, 0(sp)				# 
	addi sp, sp, 20				# 
	ret

#####
 # exibe_matriz_navios(): exibe a matriz de navios
exibe_matriz_navios:	
	la a3, matriz_posicoes 		# 
	la a4, cabecalho_matriz_navios		# carrega label do arquivo "PromptTexts.asm" no reg. A4
	jal imprime_matriz_posicoes		# função do arquivo "CharMatrixFunctions"
	la a0, prompt_continuar		# carrega prompt de pausa
	li a7, 4				# carrega código ecall PrintString
	ecall					# 
	li a7, 8				# carrega código ecall 
	ecall					# 
	j loop_jogo				# retorna ao loop principal do jogo
	
#####
 # input_tiro(): realiza tiro na matriz
input_tiro:
	la a2, vetor_xy				# carrega ponteiro do vetor de coordenadas de input
	jal solicita_input_tiro		# função do arquivo "PromptFunctions.asm", retorna em a0
	addi a2, a0, 0 				# carrega ponteiro do vetor de coordenadas de input
	la a3, matriz_posicoes			# carrega ponteiro da matriz de caracteres de navios 
	la a4, matriz_tiros			# carrega ponteiro da matriz de caracteres de tiros
	jal testa_e_marca_se_acertou		# testa se o tiro acertou algum navio
	j loop_jogo				# retorna ao loop de jogo

#####
 # testa_e_marca_se_acertou(a2,a3,a4): realiza tiro na matriz
 #      a2: ponteiro do vetor de coordenadas
 #	a3: ponteiro da matriz de caracteres de navios	
 # 	a4: ponteiro da matriz de caracteres de tiros
testa_e_marca_se_acertou:
	addi sp, sp, -12			# adiciona espaço na pilha 
	sw ra, 0(sp)				# armazena endereço de retorno na pilha
	sw a3, 4(sp)				# 
	sw a4, 8(sp) 				# armazena A4 na pilha (ponteiro matriz de tiro)
	addi a4, a3, 0				# carrega A4 com ponteiro de matriz de caracteres de navios 
	lw a6, 0(a2)				# carrega A6 com coordenada de coluna para chamada de função
	lw a7, 4(a2)				# carrega A7 com coordenada de coluna para chamada de função
	jal busca_matriz_posicoes		# função do arquivo "MatrixFunctions.asm", retorna valor em A1
	lw t0, preenchimento1			# carrega o caracter '-' de preenchimento
	beq t0, a1, errou_o_tiro		# caso o tiro seja em um local com caracter de preenchimento, errou
	li t1, 0x5A				# carrega código ASCII da letra Z
	ble a1, t1, acertou_o_tiro		# caso o caracter da matriz esteja no interfalo de letras maiusculas, acertou
	j fim_teste_tiro
acertou_o_tiro:
	#TODO colocar tiro no vetor de erros para as estatísticas
	lw a4, 4(sp)				# carrega ponteiro da matriz de caracteres em A4  
	addi a5, a5, 31				# adiciona valor 31 para tornar letra minúscula
	jal insere_matriz_posicoes		# função do arquivo "MatrixFunctions.asm"	
	lw a4, 8(sp)				# carrega valor de A4 (ponteiro matriz de tiro)
	lw a5, char_tiro_certeiro		# carrega letra 'x'
	jal insere_matriz_posicoes		# função do arquivo "MatrixFunctions.asm"	
	j fim_teste_tiro
errou_o_tiro:
	#TODO colocar tiro no vetor de erros para as estatísticas
	lw a4, 4(sp)				# carrega ponteiro da matriz de caracteres em A4  
	lw a5, char_tiro_nagua			# carrega letra 'o'
	jal insere_matriz_posicoes		# função do arquivo "MatrixFunctions.asm"	
	lw a4, 8(sp)				# carrega valor de A4 (ponteiro matriz de tiro)
	jal insere_matriz_posicoes		# função do arquivo "MatrixFunctions.asm"	
fim_teste_tiro:
	lw ra, 0(sp)				# retorna o valor de RA salvo na pilha de execução
	addi sp, sp, 4				# retorna para a posição anterior da pilha
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
	
	

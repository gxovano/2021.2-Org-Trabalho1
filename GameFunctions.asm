#####
 # inicio_do_jogo(a2,a3,a4,a5): inicializa��o do jogo
 #      a2: ponteiro para string representando a matriz de embarca��es
 #      a3: ponteiro para matriz de embarca��es
 #      a4: ponteiro para matriz de caracteres de posi��es
 #      a5: ponteiro para matriz de caracteres de tiros
inicio_do_jogo:
	addi sp, sp, -20
	sw ra, 0(sp)
	sw a2, 4(sp)				# salva valor de A2 na pilha para chamada de fun��o 
	sw a3, 8(sp)				# salva valor de A3 na pilha para chamada de fun��o
	sw a4, 12(sp)				# salva valor de A4 na pilha para chamada de fun��o
	sw a5, 16(sp)				# salva valor de A5 na pilha para chamada de fun��o
	#TODO convers�o da string de navios para a matriz de embarca��es
	lw a3, 12(sp)				# carrega ponteiro da matriz de caracteres de posi��es
	jal gera_matriz_vazia			# insere caracteres de preenchimento na matriz
	lw a3, 16(sp)				# carrega ponteiro da matriz de caracteres de tiros
	jal gera_matriz_vazia			# insere caracteres de preenchimento na matriz
	lw a2, 8(sp)				# carrega ponteiro da matriz de embarca��es
	lw a3, 12(sp)				# carrega ponteiro da matriz de caracteres de navios
	jal gera_matriz_posicoes		# insere navios na matriz de navios
	lw ra, 0(sp)				# retorna o valor de RA salvo na pilha de execu��o
	addi sp, sp, 20				# retorna para a posi��o anterior da pilha
	ret
	
#####
 # exibe_matriz_navios(): exibe a matriz de navios
exibe_matriz_navios:	
	la a3, matriz_posicoes 		# 
	la a4, cabecalho_matriz_navios		# carrega label do arquivo "PromptTexts.asm" no reg. A4
	jal imprime_matriz_posicoes		# fun��o do arquivo "CharMatrixFunctions"
	la a0, prompt_continuar		# carrega prompt de pausa
	li a7, 4				# carrega c�digo ecall PrintString
	ecall					# 
	li a7, 8				# carrega c�digo ecall 
	ecall					# 
	j loop_jogo				# retorna ao loop principal do jogo

#####
 # input_tiro(): realiza tiro na matriz
input_tiro:
	la a2, vetor_xy				# carrega ponteiro do vetor de coordenadas de input
	jal solicita_input_tiro		# fun��o do arquivo "PromptFunctions.asm", retorna em a0
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
	addi sp, sp, -12			# adiciona espa�o na pilha 
	sw ra, 0(sp)				# armazena endere�o de retorno na pilha
	sw a3, 4(sp)				# 
	sw a4, 8(sp) 				# armazena A4 na pilha (ponteiro matriz de tiro)
	addi a4, a3, 0				# carrega A4 com ponteiro de matriz de caracteres de navios 
	lw a6, 0(a2)				# carrega A6 com coordenada de coluna para chamada de fun��o
	lw a7, 4(a2)				# carrega A7 com coordenada de coluna para chamada de fun��o
	jal busca_matriz_posicoes		# fun��o do arquivo "MatrixFunctions.asm", retorna valor em A1
	lw t0, preenchimento1			# carrega o caracter '-' de preenchimento
	beq t0, a1, errou_o_tiro		# caso o tiro seja em um local com caracter de preenchimento, errou
	li t1, 0x5A				# carrega c�digo ASCII da letra Z
	ble a1, t1, acertou_o_tiro		# caso o caracter da matriz esteja no interfalo de letras maiusculas, acertou
	j fim_teste_tiro
acertou_o_tiro:
	addi a5, a2, 0				# carrega ponteiro do vetor de coordenadas
	la a4, vetor_tiros_acertados 		# carrega vetor de tiros acertados para chamada da fun��o
	jal insere_tupla2_vetor 		# fun��o do arquivo "VectorFunctions.asm"
	lw a4, 4(sp)				# carrega ponteiro da matriz de caracteres em A4  
	addi a5, a1, 32				# adiciona valor 31 para tornar letra min�scula
	jal insere_matriz_posicoes		# fun��o do arquivo "MatrixFunctions.asm"	
	lw a4, 8(sp)				# carrega valor de A4 (ponteiro matriz de tiro)
	lw a5, char_tiro_certeiro		# carrega letra 'x'
	jal insere_matriz_posicoes		# fun��o do arquivo "MatrixFunctions.asm"	
	j fim_teste_tiro
errou_o_tiro:
	addi a5, a2, 0				# carrega ponteiro do vetor de coordenadas
	la a4, vetor_tiros_errados 		# carrega vetor de tiros acertados para chamada da fun��o
	jal insere_tupla2_vetor 		# fun��o do arquivo "VectorFunctions.asm"
	lw a4, 4(sp)				# carrega ponteiro da matriz de caracteres em A4  
	lw a5, char_tiro_nagua			# carrega letra 'o'
	jal insere_matriz_posicoes		# fun��o do arquivo "MatrixFunctions.asm"	
	lw a4, 8(sp)				# carrega valor de A4 (ponteiro matriz de tiro)
	jal insere_matriz_posicoes		# fun��o do arquivo "MatrixFunctions.asm"	
fim_teste_tiro:
	lw ra, 0(sp)				# retorna o valor de RA salvo na pilha de execu��o
	addi sp, sp, 4				# retorna para a posi��o anterior da pilha
	ret

#####
 # reiniciar_jogo(a2,a3): reinicializa as matrizes do jogo
reiniciar_jogo:
	la a2, string_embarcacoes		# carrega endere�o do string de embarca��es
	la a3, matriz_embarcacoes		# carrega endere�o da matriz de embarca��es
	la a4, matriz_posicoes			# carrega endere�o da matriz de caracteres de posi��es
	la a5, matriz_tiros			# carrega endere�o da matriz de caracteres de tiros
	jal inicio_do_jogo			# inicializa o conte�do das matrizes
	j loop_jogo

#####
 # insere_embarcacoes(a2,a3): insere a embarca��o na matriz
 #      a2: ponteiro do vetor representando o navio
 #	a3: ponteiro do in�cio da matriz
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
	lw a6, 0(a3)				# n�meros de linhas na matriz
	addi s0, a2, 0				# contador de elementos do vetor
	li t2, 0				# contador de colunas
	addi a7, t2, 0
	li t4, 4				# n�mero de colunas da matriz de navios
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

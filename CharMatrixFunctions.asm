#####
 # gera_matriz_vazia(a3): preenche matriz de caracteres
 #      a3: ponteiro para matriz de caracteres
gera_matriz_vazia:
	addi sp, sp, -4			# adiciona espa�o na pilha 
	sw ra, 0(sp)			# armazena endere�o de retorno na pilha
	addi a4, a3, 0			# copia o endere�o da matriz para A4
	lw a5, preenchimento1		# caracter vazio
	lw s1, ordem			# ordem da matriz
	li a6, 0			# contador de linha
	li a7, 0			# contador de coluna
loop_vazio:	
	jal insere_matriz_posicoes	# insere elemento na matriz de posi��es
	addi a7, a7, 1			# incrementa �ndice de coluna
	bne a7, s1, loop_vazio		# caso n�o tenha chegado at� a �ltima coluna, repetir
	srli a7, a7, 15			# zera o �ndice de coluna
	addi a6, a6, 1			# incrementa �ndice de linha
	bne a6, s1, loop_vazio		# caso n�o tenha chegado at� a �ltima linha, repetir
	lw ra, 0(sp)			# retorna o valor de RA salvo na pilha de execu��o
	addi sp, sp, 4			# retorna para a posi��o anterior da pilha
	ret
	
#####
 # imprime_matriz_posicoes(a3, a4): preenche matriz de caracteres
 #      a3: ponteiro para matriz de caracteres
 # 	a4: cabe�alho da matriz
imprime_matriz_posicoes:
	addi sp, sp, -8			# adiciona espa�o na pilha 
	sw ra, 0(sp)			# armazena endere�o de retorno na pilha
	addi a0, a4, 0 			# carrega cabecalho da matriz de navios
	li a7, 4			# carrega ecall PrintString
	ecall				# 
	addi a4, a3, 0			# copia o endere�o da matriz para A4
	li s0, 0x20			# caracter de espa�o
	lw s1, ordem			# ordem da matriz
	li a6, 0			# contador de linha
	addi a0, a6, 0			# carrega indice da linha
	li a7, 1 			# carrega valor de ecall PrintInt
	ecall				#
	li a7, 0			# contador de coluna
loop_vazia_linha:	
	jal busca_matriz_posicoes	# insere elemento na matriz de posi��es
	sw a7, 4(sp)			# salva o valor de a7(�ndice de coluna) na pilha de execu��o para ecall
	addi a0, s0, 0			# carrega valor ASCII de espa�o
	li a7, 11			# carrega ecall PrintChar
	ecall				#
	addi a0, a1, 0			# carrega elemento da matriz para impress�o
	ecall				#
	lw a7, 4(sp)			# retorna valor de A7 salvo na pilha
	addi a7, a7, 1			# incrementa �ndice de coluna
	bne a7, s1, loop_vazia_linha	# caso n�o tenha chegado at� a �ltima coluna, repetir
	
	li a0, 10			# carrega valor ASCII de Nova Linha
	li a7, 11			# carrega valor de ecall PrintChar
	ecall				#
	srli a7, a7, 15			# zera o �ndice de coluna
	addi a6, a6, 1			# incrementa �ndice de linha
	addi a0, a6, 0			# carrega indice da linha
	li a7, 1 			# carrega valor de ecall PrintInt
	ecall				#
	li a7, 0			# zera o valor do contador de colunas
	bne a6, s1, loop_vazia_linha	# caso n�o tenha chegado at� a �ltima linha, repetir
	la a0, rodape_matriz_navios
	li a7, 4
	ecall
	lw ra, 0(sp)			# retorna o valor de RA salvo na pilha de execu��o
	addi sp, sp, 8			# retorna para a posi��o anterior da pilha
	ret	

#####
 # gera_matriz_posicoes(a2,a3): preenche matriz de caracteres
 #      a2: ponteiro para matriz de embarcacoes
 #      a3: ponteiro para matriz de caracteres
gera_matriz_posicoes:
	addi sp, sp, -4			# adiciona espa�o na pilha 
	sw ra, 0(sp)			# armazena endere�o de retorno na pilha
	lw s0, 0(a2)			# n�mero de embarca��es
	lw a4, inicio_maiusculas	# n�mero ASCII inicial das mai�sculas  
	li s2, 0			# contador de embarca��es
	addi sp, sp, -12		# salvar vari�veis
	addi a2, a2, 4			# avan�a 1 word (4 bytes) no endere�o de mem�ria
loop_embarcacoes:
	sw a2, 0(sp)			# salva a2 na pilha
	sw a3, 4(sp)			# salva a3 na pilha
	sw a4, 8(sp) 			# salva a4 na pilha
	jal insere_embarcacao_posicao	# chama fun��o 
	lw a2, 0(sp)			# recupera a2 da pilha
	lw a3, 4(sp)			# recupera a3 da pilha
	lw a4, 8(sp)			# recupera a4 da pilha
	addi s2, s2, 1			# incrementa contador de embarca��es
	addi a4, a4, 1			# incrementa n�mero de letra para representar a pr�xima embarca��o
	addi a2, a2, 16			# avan�a 1 word (4 bytes) no endere�o de mem�ria
	bne s0, s2, loop_embarcacoes	# caso ainda existam embarca��es a inserir, atualizar
	addi sp, sp, 12 		# retorna o ponteiro da pilha para RA
	lw ra, 0(sp)			# retorna o valor de RA salvo na pilha de execu��o
	addi sp, sp, 4			# retorna para a posi��o anterior da pilha
	ret
	
#####
 # insere_embarcacao_posicao(a2,a3,a4): insere embarca��o na matriz de posi��es
 #      a2: ponteiro para matriz de embarcacoes	
 #	a3: ponteiro para matriz de caracteres
 #      a4: caracter representando o navio	
insere_embarcacao_posicao:
	addi sp, sp, -4			# adiciona espa�o na pilha 
	sw ra, 0(sp)			# armazena endere�o de retorno na pilha
	lw s3, 0(a2)			# carrega orienta��o da embarca��o
	lw s4, 4(a2)			# carrega comprimento da embarca��o
	lw a6, 8(a2)			# carrega n�mero da linha
	lw a7, 12(a2)			# carrega n�mero da coluna 
	li s5, 1 			# contador de itens
	addi a5, a4, 0			# copia registrador para chamada da fun��o
	addi a4, a3, 0			# copia registrador para chamada da fun��o
	bnez s3, insere_embarcacao_posicao_vertical	# se orienta��o n�o for 0 (vertical), pula
	beqz s3, insere_embarcacao_posicao_horizontal	# se orienta��o for 0 (horizontal), pula
insere_embarcacao_posicao_vertical:
	jal insere_matriz_posicoes	# chama fun��o para inserir na matriz de posi��es
	addi s5, s5, 1			# incrementa contador de comprimento
	addi a6, a6, 1			# incrementa posi��o da linha
	ble s5, s4, insere_embarcacao_posicao_vertical # enquanto n�o tiver o comprimento, continua colocando chars
	j fim_insere_posicao		# pula para o final da fun��o
insere_embarcacao_posicao_horizontal:
	jal insere_matriz_posicoes	# fun��o no arquivo "MatrixFunctions.asm", insere caracter representando o navio
	addi s5, s5, 1			# incrementa contador de comprimento
	addi a7, a7, 1			# incrementa posi��o da coluna
	ble s5, s4, insere_embarcacao_posicao_horizontal # enquanto n�o tiver o comprimento, continua colocando chars
fim_insere_posicao:
	lw ra, 0(sp)			# retorna o valor de RA salvo na pilha de execu��o
	addi sp, sp, 4			# retorna para a posi��o anterior da pilha
	ret

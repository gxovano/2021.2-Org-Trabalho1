#####
 # gera_matriz_vazia(a3): preenche matriz de caracteres
 #      a3: ponteiro para matriz de caracteres
gera_matriz_vazia:
	addi sp, sp, -4			# adiciona espaço na pilha 
	sw ra, 0(sp)			# armazena endereço de retorno na pilha
	addi a4, a3, 0			# copia o endereço da matriz para A4
	lw a5, preenchimento1		# caracter vazio
	lw s1, ordem			# ordem da matriz
	li a6, 0			# contador de linha
	li a7, 0			# contador de coluna
loop_vazio:	
	jal insere_matriz_posicoes	# insere elemento na matriz de posições
	addi a7, a7, 1			# incrementa índice de coluna
	bne a7, s1, loop_vazio		# caso não tenha chegado até a última coluna, repetir
	srli a7, a7, 15			# zera o índice de coluna
	addi a6, a6, 1			# incrementa índice de linha
	bne a6, s1, loop_vazio		# caso não tenha chegado até a última linha, repetir
	lw ra, 0(sp)			# retorna o valor de RA salvo na pilha de execução
	addi sp, sp, 4			# retorna para a posição anterior da pilha
	ret
	
#####
 # imprime_matriz_posicoes(a3, a4): preenche matriz de caracteres
 #      a3: ponteiro para matriz de caracteres
 # 	a4: cabeçalho da matriz
imprime_matriz_posicoes:
	addi sp, sp, -8			# adiciona espaço na pilha 
	sw ra, 0(sp)			# armazena endereço de retorno na pilha
	addi a0, a4, 0 			# carrega cabecalho da matriz de navios
	li a7, 4			# carrega ecall PrintString
	ecall				# 
	addi a4, a3, 0			# copia o endereço da matriz para A4
	li s0, 0x20			# caracter de espaço
	lw s1, ordem			# ordem da matriz
	li a6, 0			# contador de linha
	addi a0, a6, 0			# carrega indice da linha
	li a7, 1 			# carrega valor de ecall PrintInt
	ecall				#
	li a7, 0			# contador de coluna
loop_vazia_linha:	
	jal busca_matriz_posicoes	# insere elemento na matriz de posições
	sw a7, 4(sp)			# salva o valor de a7(índice de coluna) na pilha de execução para ecall
	addi a0, s0, 0			# carrega valor ASCII de espaço
	li a7, 11			# carrega ecall PrintChar
	ecall				#
	addi a0, a1, 0			# carrega elemento da matriz para impressão
	ecall				#
	lw a7, 4(sp)			# retorna valor de A7 salvo na pilha
	addi a7, a7, 1			# incrementa índice de coluna
	bne a7, s1, loop_vazia_linha	# caso não tenha chegado até a última coluna, repetir
	
	li a0, 10			# carrega valor ASCII de Nova Linha
	li a7, 11			# carrega valor de ecall PrintChar
	ecall				#
	srli a7, a7, 15			# zera o índice de coluna
	addi a6, a6, 1			# incrementa índice de linha
	addi a0, a6, 0			# carrega indice da linha
	li a7, 1 			# carrega valor de ecall PrintInt
	ecall				#
	li a7, 0			# zera o valor do contador de colunas
	bne a6, s1, loop_vazia_linha	# caso não tenha chegado até a última linha, repetir
	la a0, rodape_matriz_navios
	li a7, 4
	ecall
	lw ra, 0(sp)			# retorna o valor de RA salvo na pilha de execução
	addi sp, sp, 8			# retorna para a posição anterior da pilha
	ret	

#####
 # gera_matriz_posicoes(a2,a3): preenche matriz de caracteres
 #      a2: ponteiro para matriz de embarcacoes
 #      a3: ponteiro para matriz de caracteres
gera_matriz_posicoes:
	addi sp, sp, -4			# adiciona espaço na pilha 
	sw ra, 0(sp)			# armazena endereço de retorno na pilha
	lw s0, 0(a2)			# número de embarcações
	lw a4, inicio_maiusculas	# número ASCII inicial das maiúsculas  
	li s2, 0			# contador de embarcações
	addi sp, sp, -12		# salvar variáveis
	addi a2, a2, 4			# avança 1 word (4 bytes) no endereço de memória
loop_embarcacoes:
	sw a2, 0(sp)			# salva a2 na pilha
	sw a3, 4(sp)			# salva a3 na pilha
	sw a4, 8(sp) 			# salva a4 na pilha
	jal insere_embarcacao_posicao	# chama função 
	lw a2, 0(sp)			# recupera a2 da pilha
	lw a3, 4(sp)			# recupera a3 da pilha
	lw a4, 8(sp)			# recupera a4 da pilha
	addi s2, s2, 1			# incrementa contador de embarcações
	addi a4, a4, 1			# incrementa número de letra para representar a próxima embarcação
	addi a2, a2, 16			# avança 1 word (4 bytes) no endereço de memória
	bne s0, s2, loop_embarcacoes	# caso ainda existam embarcações a inserir, atualizar
	addi sp, sp, 12 		# retorna o ponteiro da pilha para RA
	lw ra, 0(sp)			# retorna o valor de RA salvo na pilha de execução
	addi sp, sp, 4			# retorna para a posição anterior da pilha
	ret
	
#####
 # insere_embarcacao_posicao(a2,a3,a4): insere embarcação na matriz de posições
 #      a2: ponteiro para matriz de embarcacoes	
 #	a3: ponteiro para matriz de caracteres
 #      a4: caracter representando o navio	
insere_embarcacao_posicao:
	addi sp, sp, -4			# adiciona espaço na pilha 
	sw ra, 0(sp)			# armazena endereço de retorno na pilha
	lw s3, 0(a2)			# carrega orientação da embarcação
	lw s4, 4(a2)			# carrega comprimento da embarcação
	lw a6, 8(a2)			# carrega número da linha
	lw a7, 12(a2)			# carrega número da coluna 
	li s5, 1 			# contador de itens
	addi a5, a4, 0			# copia registrador para chamada da função
	addi a4, a3, 0			# copia registrador para chamada da função
	bnez s3, insere_embarcacao_posicao_vertical	# se orientação não for 0 (vertical), pula
	beqz s3, insere_embarcacao_posicao_horizontal	# se orientação for 0 (horizontal), pula
insere_embarcacao_posicao_vertical:
	jal insere_matriz_posicoes	# chama função para inserir na matriz de posições
	addi s5, s5, 1			# incrementa contador de comprimento
	addi a6, a6, 1			# incrementa posição da linha
	ble s5, s4, insere_embarcacao_posicao_vertical # enquanto não tiver o comprimento, continua colocando chars
	j fim_insere_posicao		# pula para o final da função
insere_embarcacao_posicao_horizontal:
	jal insere_matriz_posicoes	# função no arquivo "MatrixFunctions.asm", insere caracter representando o navio
	addi s5, s5, 1			# incrementa contador de comprimento
	addi a7, a7, 1			# incrementa posição da coluna
	ble s5, s4, insere_embarcacao_posicao_horizontal # enquanto não tiver o comprimento, continua colocando chars
fim_insere_posicao:
	lw ra, 0(sp)			# retorna o valor de RA salvo na pilha de execução
	addi sp, sp, 4			# retorna para a posição anterior da pilha
	ret

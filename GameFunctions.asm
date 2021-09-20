#####
 # reiniciar_jogo(a2,a3): reinicializa as matrizes do jogo
reiniciar_jogo:
	la a3, matriz_embarcacoes		# carrega endere�o da matriz de embarca��es
	la a4, matriz_posicoes			# carrega endere�o da matriz de caracteres de posi��es
	la a5, matriz_tiros			# carrega endere�o da matriz de caracteres de tiros
	jal inicio_do_jogo			# inicializa o conte�do das matrizes
	j fim_loop_jogo

#####
 # input_tiro(): realiza tiro na matriz
input_tiro:
	la a2, vetor_xy				# carrega ponteiro do vetor de coordenadas de input
	jal solicita_input_tiro		# fun��o do arquivo "PromptFunctions.asm", retorna em a0
	addi a2, a0, 0 				# carrega ponteiro do vetor de coordenadas de input
	la a3, matriz_posicoes			# carrega ponteiro da matriz de caracteres de navios 
	la a4, matriz_tiros			# carrega ponteiro da matriz de caracteres de tiros
	la t0, vetor_ultimo_tiro		# carrega ponteiro do vetor de �ltimo tiro
	lw t1, 0(a2)				# 
	sw t1, 0(t0)				# 
	lw t1, 4(a2)				# 
	sw t1, 4(t0)				# 
	jal testa_e_marca_se_acertou		# testa se o tiro acertou algum navio
	j fim_loop_jogo

#####
 # exibe_matriz_navios(): exibe a matriz de navios
exibe_matriz_navios:	
	la a3, matriz_posicoes 		# 
	la a4, cabecalho_matriz_navios		# carrega label do arquivo "PromptTexts.asm" no reg. A4
	jal imprime_matriz_posicoes		# fun��o do arquivo "CharMatrixFunctions.asm"
	la a0, prompt_continuar		# carrega prompt de pausa
	li a7, 4				# carrega c�digo ecall PrintString
	ecall					# 
	li a7, 8				# carrega c�digo ecall 
	ecall					# 
	j fim_loop_jogo
	
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
 # estatisticas_jogo(): mostra as estatisticas para o usu�rio
estatisticas_jogo:
	addi sp, sp, -4				# reserva espa�o na pilha de execu��o
	sw ra, 0(sp)				# salva RA na pilha de execu��o
	lw s0, vetor_tiros_acertados		# recupera total de tiros acertados
	lw s1, vetor_tiros_errados		# recupera total de tiros errados
	add s2, s0, s1				# total = acertados + errados
	#
	la a2, separador_prompt		# 
	jal adiciona_ao_buffer_pointers	# 
	# msg total
	la a2, divisor				# carrega endere�o do divisor
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	la a2, msg_qtd_total_tiros		# carrega ponteiro da mensagem
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	# nro total
	addi a2, s2, 0				# carrega nro total tiros
	jal adiciona_int_ao_buffer_words 	# adiciona ao buffer de conteudos
	addi a2, a0, 0				#
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	# msg acertados
	la a2, divisor				# carrega endere�o do divisor
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	la a2, msg_qtd_tiros_certeiros		# carrega ponteiro da mensagem
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	# nro acertados
	addi a2, s0, 0				# carrega nro tiros acertados
	jal adiciona_int_ao_buffer_words 	# adiciona ao buffer de conteudos
	addi a2, a0, 0				#
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	# msg errados
	la a2, divisor				# carrega endere�o do divisor
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	la a2, msg_qtd_tiros_nagua		# carrega ponteiro da mensagem
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	# nro errados
	addi a2, s1, 0				# carrega nro tiros n'�gua
	jal adiciona_int_ao_buffer_words 	# adiciona ao buffer de conteudos
	addi a2, a0, 0				# carrega para a vari�vel de entrada
	jal adiciona_ao_buffer_pointers	# adiciona ao buffer de ponteiros
	# print buffer
	jal print_buffer_pointers		# fun��o do arquivo "MatrixFunctions.asm"
	# limpa bufferes
	jal limpa_buffer_pointers 		# limpa o buffer_pointers
	jal limpa_buffer_words			# limpa o buffer_words
	# fim
	lw ra, 0(sp)				# recupera o RA da pilha
	addi sp, sp, 4				# reseta a pilha
	ret

#####
 # insere_embarcacoes(a2): insere a embarca��o na matriz
 #      a2: ponteiro da string representando as embarca��es
insere_embarcacoes:
	#addi sp, sp, -4				# reserva espa�o na pilha de execu��o
	#sw ra, 0(sp)				# salva RA na pilha de execu��o
	la t1, matriz_embarcacoes		# carrega endere�o da matriz tempor�ria
	lw t0, 0(a2)				# carrega primeiro valor da string (nro embarca��es)
	addi t0, t0, -48			# subtrai 48 para obter o n�mero em lugar do c�digo ASCII
	sw t0, 0(t1)				# armazena na matriz de embarca��es 
	addi t2, a2, 0				# copia valor do endere�o da matriz
	li t3, ' '				# carrega valor espa�o
	li t4, '\n'				# carrega valor nova linha
	li t6, '\0'				# carrega valor de fechamento de string
loop_string:
	addi t2, t2, 4				# avan�a caracter na string
	addi t1, t1, 4				# avan�a posi��o na matriz
	lw t5, 0(t2)				# carrega valor
	beq t5, t3, loop_string		# se for espa�o, continua
	beq t5, t4, loop_string		# se for nova linha, continua
	beq t5, t5, fim_loop_conversao		# se for fim da string, fim
	sw t5, 0(t1)				# armazena o valor na matriz de embarca��es
	j loop_string
fim_loop_conversao:
	#lw ra, 0(sp)
	#addi sp, sp, 4
	ret	

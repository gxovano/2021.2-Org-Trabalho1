#####
 # testeAB_vetor(a2): testa caso A e B de inclusão na matriz de navios
 #  Caso A: As coordenadas são maiores que o permitido
 #  Caso B: A coordenada inicial + o comprimento do navio é maior que o tamanho da matriz
 #      a2: ponteiro do vetor representando o navio
 #	-> a0: codigo de erro
testeAB_vetor:
	li a0, 10			# carrega ordem da matriz
	li t0, 1			# 
	lw t1, 0(a2)			# 
	lw t2, 4(a2)			# 
	lw t3, 8(a2)			# 
	srli t6, t6, 16			# 
	addi t6, t6, 1			# 
	bgt t3, a0, fim_erro		# 
	lw t3, 12(a2)			# 
	bgt t3, a0, fim_erro		# 
	beqz t1, testa_horizontal	# 
testa_vertical:
	lw t4, 8(a2)			# 
	j testa_estouro
testa_horizontal:
	lw t4, 12(a2)
testa_estouro:
	add t5, t4, t2
	addi t6, t6, 2
	bge t5, a0, fim_erro
	srli a0, a0, 31
fim_normal:
	addi a0, a0, 0
	ret
fim_erro:
	addi a0, t6, 0
	ret

#####
 # teste_sobreposicao(a2,a3): testa a sobreposição entre a embarcação a ser inserida e as já existentes 
 #      a2: ponteiro do vetor representando o navio
 #	a3: ponteiro do início da matriz
 #	-> a0: código de erro ou "zero" = exito
teste_sobreposicao:
	addi sp, sp, -4
	sw ra, 0(sp)
	jal gerar_vetor_logico
	addi s0, a0, 0
		
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

#####
 # gerar_vetor_logico(a2): gera vetor de bits representando a embarcação
 #  O MSB do vetor de bits é a posição de início (coordenada inicial vertical ou horizontal)
 #      a2: ponteiro do vetor representando a embarcação
 #	-> a0: vetor de bits
gerar_vetor_logico:
	li t0, 1			# contador do loop de adição de bits
	li t1, 1			# registrador vetor de bits
	lw t2, 4(a2)			# carrega comprimento da embarcação
loop_gerador:
	slli t1, t1, 1			# rola à esquerda para abrir espaço para novo bit à direita
	addi t1, t1, 1			# adiciona bit ao vetor
	addi t0, t0, 1			# contador ++
	bne t0, t2, loop_gerador	# caso vetor não possua o comprimento da embarcação, continua adição
	li t2, 10			# ordem da matriz
	lw t3, 4(a2)			# tamanho da embarcação
	lw t4, 0(a2)			# orientação da embarcação
	beqz t4, ajusta_horizontal	
	bnez t4, ajusta_vertical
ajusta_horizontal:
	lw t4, 8(a2)			# usa coordenada horizontal como posição inicial (MSB)
	j alinha_vetor
ajusta_vertical:	
	lw t4, 12(a2)			# usa coordenada vertical como posição inicial (MSB)
alinha_vetor:				# alinha os bits adicionados no loop com a posição inicial
	sub t5, t2, t3			# (ordem) - (comprimento)
	sub t5, t5, t4 			# (ordem) - (comprimento) - MSB
	sll a0, t1, t5			# rola todos os bits do vetor até a posição inicial, à esquerda
	ret
	

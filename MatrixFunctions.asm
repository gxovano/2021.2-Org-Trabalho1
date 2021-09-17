#####
 # insere_matriz_embarcacoes(a4,a5,a6,a7): insere um elemento em uma posicao da matriz
 #      a4: ponteiro do inicio da matriz (P)
 #      a5: elemento a ser armazenado (E)
 # 	a6: linha da matriz (L)
 #	a7: coluna da matriz (C)
insere_matriz_embarcacoes:
	lw t1, 0(a4)			# ponteiro para a posi��o inicial da matriz de embarca��es
	li t2, 4			# n�mero de colunas na matriz (Q)
	mul t3, a6, t2			# L * Q
	add t3, t3, a7			# L * Q + C
	li t2, 4			# n�mero de bytes de deslocamento = 4 bytes
	mul t3, t3, t2			# deslocamento = (L * Q + C) * 4
	add t1, a4, t3			# P + deslocamento
	sw a5, 0(t1)			# armazena E em na posi��o (P + deslocamento)
	ret

#####
 # insere_matriz_posicoes(a4,a5,a6,a7): insere um caracter em uma posicao da matriz
 #      a4: ponteiro do inicio da matriz (P)
 #      a5: caracter a ser armazenado (E)
 # 	a6: linha da matriz (L)
 #	a7: coluna da matriz (C)
insere_matriz_posicoes:
	lw t1, 0(a4)			# ponteiro para a posi��o inicial da matriz de caracteres
	lw t2, ordem			# n�mero de colunas na matriz (Q)
	mul t3, a6, t2			# L * Q
	add t3, t3, a7			# L * Q + C
	add t1, a4, t3			# P + deslocamento
	sb a5, 0(t1)			# armazena E em na posi��o (P + deslocamento)
	ret

#####
 # busca_matriz_posicoes(a4,a6,a7): retorna um caracter da matriz de posi��es
 #      a4: ponteiro do inicio da matriz (P)
 # 	a6: linha da matriz (L)
 #	a7: coluna da matriz (C)
busca_matriz_posicoes:
	lw t1, 0(a4)			# ponteiro para a posi��o inicial da matriz de caracteres
	lw t2, ordem			# n�mero de colunas na matriz (Q)
	mul t3, a6, t2			# L * Q
	add t3, t3, a7			# L * Q + C
	add t1, a4, t3			# P + deslocamento
	lb a1, 0(t1)			# carrega E na posi��o (P + deslocamento) no registrador de retorno
	ret
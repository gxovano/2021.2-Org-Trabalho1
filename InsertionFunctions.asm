#####
 # insere_embarcacoes: insere um elemento em uma posicao da matriz
 #      a4: ponteiro do inicio da matriz
 #      a5: elemento a ser armazenado
 # 	a6: linha da matriz
 #	a7: coluna da matriz
insere_matriz_embarcacoes:
	lw t1, 0(a4)			# ponteiro para a posição inicial da matriz de embarcacoes
	li t2, 4
	mul t3, a6, t2
	add t3, t3, a7
	li t2, 4
	mul t3, t3, t2
	add t1, a4, t3
	sw a5, 0(t1)
	ret

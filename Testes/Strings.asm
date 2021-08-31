#####
 # insere_matriz: insere um elemento em uma posicao da matriz
 #      a1: ponteiro do inicio da matriz
 #      a2: elemento a ser armazenado
 # 	a3: linha da matriz
 #	a4: coluna da matriz
insere_matriz:
	lb t1, nro_linhas
	lb t2, nro_colunas
	mul t3, a3, t2
	add t3, t3, a4
	li t2, 4
	mul t3, t3, t2
	add a1, a1, t3
	sw a3, 0(a2)
	ret
	
#####
 # busca_matriz(a1,a2,a3,a4,a5): multiplica dois inteiros
 #      a2: ponteiro do inicio da matriz
 # 	a3: linha da matriz
 #	a4: coluna da matriz	
 #	-> a0: elemento	
 
busca_matriz:
	lb t1, nro_linhas
	lb t2, nro_colunas
	mul t3, a2, t2
	add t3, t3, a3
	li t2, 4
	mul t3, t3, t2
	add a1, a1, t3
	lw a0, 0(a2)
	ret

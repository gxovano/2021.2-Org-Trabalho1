#####
 # testeAB_vetor(a2): testa caso A e B de inclusão na matriz de navios
 #  Caso A: As coordenadas são maiores que o permitido
 #  Caso B: A coordenada inicial + o comprimento do navio é maior que o tamanho da matriz
 #      a2: ponteiro do vetor representando o navio
 #	-> a0: codigo de erro
testeAB_vetor:
	lw a0, ordem
	li t0, 1
	lw t1, 0(a2)
	lw t2, 4(a2)
	lw t3, 8(a2)
	srli t6, t6, 16
	addi t6, t6, 1
	bgt t3, a0, fim_erro
	lw t3, 12(a2)
	bgt t3, a0, fim_erro
	beqz t1, testa_horizontal
testa_vertical:
	lw t4, 8(a2)
	j testa_estouro
testa_horizontal:
	lw t4, 12(a2)
testa_estouro:
	add t5, t4, t2
	addi t6, t6, 2
	bge t5, a0, fim	_erro
	srli a0, a0, 32
fim_normal:
	ret
fim_erro:
	addi a0, t6, 0
	ret

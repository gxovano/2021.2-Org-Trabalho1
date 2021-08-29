testeAB_vetor:
	lw a0, ordem
	li t0, 1
	lw t1, 0(a2)
	lw t2, 4(a2)
	lw t3, 8(a2)
	bgt t3, a0, fim
	lw t3, 12(a2)
	bgt t3, a0, fim
	beqz t1, testa_horizontal
testa_vertical:
	lw t4, 8(a2)
	j testa_estouro
testa_horizontal:
	lw t4, 12(a2)
testa_estouro:
	add t5, t4, t2
	bge t5, a0, fim	
	srli a0, a0, 10
fim:
	ret
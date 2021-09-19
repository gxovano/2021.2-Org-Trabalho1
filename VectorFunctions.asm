#####
 # insere_tupla2_vetor(a4,a5): insere uma tupla no vetor
 #      a4: ponteiro do inicio do vetor (P)
 #		primeiro elemento do vetor(F): contador de elementos do vetor
 #      a5: ponteiro do vetor de elementos a serem armazenados (E)
insere_tupla2_vetor:
	lw t0, 0(a4)			# carrega F
	slli t0, t0, 3			# F * 2^3
	add t1, a4, t0			# P + (F * 2^3)
	addi t1, t1, 4			# P + (F * 2^3) + 4
	lw t2, 0(a5)			# carrega 1º elemento da tupla
	sw t2, 0(t1)			# salva no vetor 1º elemento da tupla
	lw t2, 4(a5)			# carrega 2º elemento da tupla
	sw t2, 4(t1)			# salva no vetor 2º elemento da tupla
	lw t0, 0(a4)			# carrega F 
	addi t0, t0, 1			# F + 1
	sw t0, 0(a4)			# salva F
	ret
	
#####
 # ultimo_elemento_vetor(a4): insere uma tupla no vetor
 #      a4: ponteiro do inicio do vetor (P)
 #		primeiro elemento do vetor(F): contador de elementos do vetor
 #      -> a0: ponteiro para o ultimo elemento
ultimo_elemento_vetor:
	lw t0, 0(a4)			# carrega F
	slli t0, t0, 3			# F * 2^3
	add t1, a4, t0			# P + (F * 2^3)
	addi t1, t1, -4			# P + (F * 2^3) - 8 (para apontar para a última tupla armazenada)
	addi a0, t1, 0			# salva t1 no registrador de retorno a0
	ret

	
	 
	 
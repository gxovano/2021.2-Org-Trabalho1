#####
 # menu_e_tiros(a2,a3,a4): exibe menu
 	# a2: ponteiro para matriz de caracteres 
 	# a3: ponteiro para cabeçalho do menu
 	# a4: ponteiro para rodapé do menu
 	# -> a0: opção escolhida
menu_e_tiros: 
	addi sp, sp, -12		# 
	sw ra, 0(sp)			# 
	sw a3, 4(sp)			# 
	sw a4, 8(sp)			# 
	la a4, cabecalho_matriz_tiro	# 
	addi a3, a2, 0			# 
	jal imprime_matriz_posicoes 	#
	lw a3, 4(sp) 			#
	addi a0, a3, 0 			#
	li a7, 4			#
	ecall				#
	lw a4, 8(sp)			#
	addi a0, a4, 0			# 
	ecall				#
	li a7, 5			#
	ecall				# 
	lw ra, 0(sp)			# 
	addi sp, sp, 12			# 
	ret

#####
 # solicita_input_tiro(a2): solicita ao usuário o input de coordenadas do tiro
 	# a2: ponteiro para vetor de coordenadas (x,y)
solicita_input_tiro:
	la a0, digite_linha_tiro	# 
	li a7, 4			# 
	ecall				# 
	li a7, 5			# 
	ecall				# 
	sw a0, 0(a2)			# 
	la a0, digite_coluna_tiro	# 
	li a7, 4			# 
	ecall				# 
	li a7, 5			# 
	ecall				# 
	sw a0, 4(a2)			# 
	addi a0, a2, 0			# 
	ret				

#####
 # input_navio(a2): prompt de input exibe menu
input_navio:
#	la t0, vetor_v
	la a0, digite_orientacao
	li a7, 4
	ecall
	li a7, 5
	ecall
	sw a0, 0(t0)
	addi t0, t0, 4
	
	la a0, digite_comprimento
	li a7, 4
	ecall
	li a7, 5
	ecall
	sw a0, 0(t0)
	addi t0, t0, 4	
	
	la a0, digite_linha
	li a7, 4
	ecall
	li a7, 5
	ecall
	sw a0, 0(t0)
	addi t0, t0, 4
	
	la a0, digite_coluna
	li a7, 4
	ecall
	li a7, 5
	ecall
	sw a0, 0(t0)
		
	ret

###
 # mostra_erro(a2): exibe uma mensagem de erro para o usuário conforme o código
#mostra_erro:
	

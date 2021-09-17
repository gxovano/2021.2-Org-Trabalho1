#####
 # menu_e_tiros(): exibe menu
menu_e_tiros:
	
#####
 # input_navio(a2): prompt de input exibe menu
prompt_usuario:
	la t0, vetor_v
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

#####
 # imprime_matriz(a3): imprime matriz de navios
 #      a3: ponteiro do vetor representando a embarcação
#imprime_matriz:
	
	
###
 # mostra_erro(a2): exibe uma mensagem de erro para o usuário conforme o código
#mostra_erro:
	

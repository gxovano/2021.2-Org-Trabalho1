###
 # Inclus�o dos prompts para o usu�rio
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
###
 # mostra_erro(a2): exibe uma mensagem de erro para o usu�rio conforme o c�digo
#mostra_erro:
	
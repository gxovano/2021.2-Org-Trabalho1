#####
 # menu_e_tiros(a2,a3,a4): exibe menu
 	# a2: ponteiro para matriz de caracteres 
 	# a3: ponteiro para cabeçalho do menu
 	# a4: ponteiro para rodapé do menu
 	# a5: ponteiro para vetor de coordenadas 
 	# -> a0: opção escolhida
menu_e_tiros: 
	addi sp, sp, -12		# reserva espaço na pilha para 3 words (3 * 4)
	sw ra, 0(sp)			# salva RA na pilha
	sw a3, 4(sp)			# salva A3 na pilha
	sw a4, 8(sp)			# salva A4 na pilha
	la a4, cabecalho_matriz_tiro	# carrega cabeçalho da matriz de tiros (definido em "Main.asm")
	addi a3, a2, 0			# carrega ponteiro da matriz de caracteres de tiros
	jal imprime_matriz_posicoes 	# função do arquivo "CharMatrixFunctions.asm"
	jal divisor_curto		# printa divisor
	la a0, msg_ultimo_tiro		# 
	li a7, 4			# 
	ecall				# 
	la a2, vetor_ultimo_tiro	# carrega ponteiro do último tiro realizado
	jal string_tupla2		# função do arquivo "StringFunctions.asm" - Gera a string do último tiro
	la a0, buffer			# carrega ponteiro para buffer
	ecall				#
	jal divisor_n			# printa divisor
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
 # printa_erro(a2): printa mensagem para usuário conforme código de erro
 #      a2: ponteiro da string representando as embarcações	
printa_erro:
	addi sp, sp, -4			# reserva espaço na pilha para 3 words (3 * 4)
	sw ra, 0(sp)			# salva RA na pilha
	jal divisor			# 
	addi sp, sp, -4			# reserva espaço na pilha para 3 words (3 * 4)
	sw ra, 0(sp)			# salva RA na pilha
	ret

#####
 # divisor_curto(): printa divisor curto de output
divisor_curto:
	la a0, divisor			# carrega ponteiro para string "divisor"
	li a7, 4			# carrega código ecall PrintString
	ecall				# 
	ret
#####
 # divisor_n(): printa divisor com quebra de linha
divisor_n:
	la a0, menu_footer		# carrega ponteiro para string "menu_footer"
	li a7, 4			# carrega código ecall PrintString
	ecall				# 
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
 # define_string_embarcacoes(): solicita ao usuário escolher uma das 3 strings de embarcações
 	# -> a0: ponteiro para string
define_string_embarcacoes:
	la a0, msg_escolhe_string	# 
	li a7, 4			# 
	ecall				# 
	li a7, 5			# 
	ecall				# 
	li t0, 1			# 
	beq t0, a0, string1		# 
	li t0, 2			# 
	beq t0, a0, string2		# 
	li t0, 3			# 
	beq t0, a0, string3		# 
	li t0, 4			# 
	beq t0, a0, string4		# 
	li t0, 5			# 
	beq t0, a0, string5		# 
string1:
	la a0, string_embarcacoes1	# 
string2:
	la a0, string_embarcacoes2	# 
string3:
	la a0, string_embarcacoes3	# 
string4:
	la a0, string_embarcacoes4	# 
string5:
	la a0, string_embarcacoes5	# 
	ret
	
	
	

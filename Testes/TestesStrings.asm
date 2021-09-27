	.data
.include "ShipStrings.asm"
.align 2
matriz_embarcacoes: .space 400
	.text
main:
	la a2, string_embarcacoes1
	la a3, matriz_embarcacoes
	jal insere_string_embarcacoes
	
	li a7, 10
	ecall
	
#####
 # insere_embarcacoes(a2,a3): insere os elementos da string na matriz
 #      a2: ponteiro para string com as embarcacoes
 #      a3: ponteiro para matriz de embarca��es na mem�ria
insere_string_embarcacoes:
	addi s0, a2, 0				# copia endere�o da string de caracteres
	addi s1, a3, 0 				# copia endere�o da string de embarca��es
	lb t0, 0(a2)				# carrega primeiro caracter (n�mero de embarca��es) da string 
	addi t1, t0, -48 			# subtrai o n�mero do c�digo ASCII
	sb t1, 0(s1)
	li t2, ' '				# carrega caracter de nova linha 
	li t3, '\n'				# carrega caracter de espa�o
	li t4, '\0'				# carrega caracter nulo
loop_string_embarcacoes:
	addi s0, s0, 1				# avan�a caracter na string
	lb t5, 0(s0)				# carrega valor
	beq t5, t2, loop_string_embarcacoes	# se for espa�o, continua
	beq t5, t3, loop_string_embarcacoes	# se for nova linha, continua
	beq t5, t4, fim_loop_conversao		# se for fim da string, fim
	addi t5, t5, -48			# subtrai o n�mero do c�digo ASCII
	addi s1, s1, 4				# avan�a posi��o na matriz
	sw t5, 0(s1)				# armazena o valor na matriz de embarca��es
	j loop_string_embarcacoes
fim_loop_conversao:
	ret	
	
	

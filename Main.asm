	.data
.include "PromptTexts.asm"
preenchimento1: .word 0x2d 			# c�digo ASCII '-'
char_tiro_certeiro: .word 0x78			# c�digo ASCII 'x'
char_tiro_nagua: .word 0x6f			# c�digo ASCII 'o'
inicio_maiusculas: .word 0x41			# caracter inicial da representa��o dos navios 'A'
ordem: .word 10					# ordem da matriz para uso nas fun��es de 'MatrixFunctions.asm'
vetor_xy: .word 0, 0				# vetor de coordenadas para input do usu�rio
vetor_ultimo_tiro: .word 0,0 			# vetor de coordenadas do �ltimo tiro disparado 
matriz_posicoes: .space 100 
matriz_tiros: .space 100 
vetor_de_tiros: .space 100 
#matriz_embarcacoes: .space 400 
string_embarcacoes: .asciz "3\n1 5 0 0\n0 3 2 2\n1 1 3 4" 
matriz_embarcacoes: .word 3, 1, 5, 0, 0, 0, 3, 2, 2, 1, 1, 3, 4
vetor_tiros_acertados: .space 100 
vetor_tiros_errados: .space 100 
#vetor_tiros_acertados: .word 4, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4
#vetor_tiros_errados: .word 4, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4

	.text
main:	
	la a2, string_embarcacoes		# carrega endere�o do string de embarca��es
	la a3, matriz_embarcacoes		# carrega endere�o da matriz de embarca��es
	la a4, matriz_posicoes			# carrega endere�o da matriz de caracteres de posi��es
	la a5, matriz_tiros			# carrega endere�o da matriz de caracteres de tiros
	jal inicio_do_jogo			# inicializa o conte�do das matrizes
loop_jogo:					# loop de intera��o principal do jogo
	la a0, separador_prompt		# caracteres para separa��o de rodadas de output do prompt
	li a7, 4				# carrega c�digo ecall PrintString
	ecall					#
	la a2, matriz_tiros			# carrega endere�o da matriz de caracteres de tiros
	la a3, menu				# carrega endere�o do menu a ser exibido para o usu�rio
	la a4, menu_footer			# carrega endere�o do rodap�
	jal menu_e_tiros			# exibe op��es para o usu�rio
	li t0, 6				# carrega n�mero 5 para compara��o
	beq a0, t0, fim_jogo			# caso op��o digitada for 5, encerra jogo
	li t0, 1				# carrega n�mero 1 para compara��o
	beq a0, t0, exibe_matriz_navios	# caso op��o digitada for 1, exibe a matriz de navios
	li t0, 2				# carrega n�mero 2 para compara��o
	beq a0, t0, input_tiro			# caso op��o digitada for 2, solicita ao usu�rio coordenadas de tiro
	li t0, 3				# carrega n�mero 3 para compara��o
	li t0, 4				# carrega n�mero 4 para compara��o
	li t0, 5				# carrega n�mero 6 para compara��o
	beq a0, t0, reiniciar_jogo		# reinicializa as matrizes
	j loop_jogo				# continua o loop do jogo
fim_jogo:
	li a7, 10
	ecall
	
.include "PromptFunctions.asm"			# Cont�m fun��es de interface com o usu�rio 
.include "MatrixFunctions.asm"			# Cont�m fun��es de manipula��o de matrizes
.include "CharMatrixFunctions.asm"		# Cont�m fun��es para manipula��o das matrizes de caracteres
.include "VectorFunctions.asm"			# Cont�m fun��es para manipula��o dos vetores de tiros
.include "GameFunctions.asm"	 		# -----> Cont�m fun��es do menu principal do jogo (da main) <-------
.include "InsertionTests.asm" 			# x-x

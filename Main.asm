#####
	# 2021.2 - Organização de Computadores
	# Trabalho 1 - Batalha Naval
	# Professor Luciano L. Caimi
	# Estudantes:
	# Nome: Geovano Lago Quatrin 	Matrícula: 1721101007	
	# Nome: Rafaelle Arruda	Matrícula: 1721101029
#####
	.data
#####
 # Definição das constantes e das variáveis de memória.
 # Legenda dos comentários:
 	# V: variável de memória
 	# C: constante armazenada em memória
 	# Em: estrutura de dados do tipo matriz em memória
 	# Ev: estrutura de dados do tipo vetor em memória
 	# Et: estrutura de dados do tipo tupla em memória
#####
.include "PromptTexts.asm"			# C: contém strings de interface com o usuário
.include "ShipsStrings.asm"			# C: contém as strings descrevendo as embarcações
preenchimento1: .word 0x2d 			# C: código ASCII '-'
char_tiro_certeiro: .word 0x78			# C: código ASCII 'x'
char_tiro_nagua: .word 0x6f			# C: código ASCII 'o'
inicio_maiusculas: .word 0x41			# C: caracter inicial da representação dos navios 'A'
ordem: .word 10					# C: ordem da matriz para uso nas funções de 'MatrixFunctions.asm'
vetor_xy: .word 0, 0				# Et: vetor de coordenadas para input do usuário
vetor_ultimo_tiro: .word 0,0 			# Et: vetor de coordenadas do último tiro disparado 
matriz_posicoes: .space 100 			# Em: matriz de caracteres de navios
matriz_tiros: .space 100 			# Em: matriz de caracteres de tiros
matriz_embarcacoes: .space 400 		# Em: matriz de embarcações
#matriz_embarcacoes: .word 3, 1, 5, 0, 0, 0, 3, 2, 2, 1, 1, 3, 4	# C: matriz com as embarcações
vetor_tiros_acertados: .space 100 		# Ev: vetor com os tiros acertados pelo usuário
vetor_tiros_errados: .space 100 		# Ev: vetor com os tiros errados pelo usuário
buffer: .word '\0'				# V: espaço temporário para saída de processamento (buffer de output)
buffer_pointer: .space 400			# V: buffer de ponteiros para strings
buffer_words: .space 100			# V: buffer de words

	.text
main:	
	la t0, define_string_embarcacoes	#
	jalr x0, 0(t0) 				# define as embarcações que serão inseridas na matriz
	addi a2, a0, 0				# copia retorno para input da nova função
	la t0, insere_embarcacoes		#
	jalr x0, 0(t0) 				# define as embarcações que serão inseridas na matriz
	beqz a0, segue_jogo			# caso o retorno não seja zero, exibe erro ao usuário
	la t0, printa_erro			#
	jalr x0, 0(t0) 				# imprime erro para o usuário
	li a7, 10				# 
	ecall					# 
segue_jogo:
	la a3, matriz_embarcacoes		# carrega endereço da matriz de embarcações
	la a4, matriz_posicoes			# carrega endereço da matriz de caracteres de posições
	la a5, matriz_tiros			# carrega endereço da matriz de caracteres de tiros
	la t0, inicio_do_jogo
	jalr x0, 0(t0)				# inicializa o conteúdo das matrizes
loop_jogo:					# loop de interação principal do jogo
	la a0, separador_prompt		# caracteres para separação de rodadas de output do prompt
	li a7, 4				# carrega código ecall PrintString
	ecall					#
	la a2, matriz_tiros			# carrega endereço da matriz de caracteres de tiros
	la a3, menu				# carrega endereço do menu a ser exibido para o usuário
	la a4, menu_footer			# carrega endereço do rodapé
	la a5, vetor_ultimo_tiro		# carrega vetor do último tiro
	la t0, menu_e_tiros			# 
	jalr x0, 0(t0)				# exibe opções para o usuário
	li t1, 0				# 
	li t0, 5				# carrega número 5 para comparação
	beq a0, t0, fim_jogo			# caso opção digitada for 5, encerra jogo
	li t0, 1				# carrega número 1 para comparação
	beq a0, t0, exibe_matriz_navios	# caso opção digitada for 1, exibe a matriz de navios
	li t0, 2				# carrega número 2 para comparação
	beq a0, t0, input_tiro			# caso opção digitada for 2, solicita ao usuário coordenadas de tiro
	li t0, 3				# carrega número 3 para comparação
	beq a0, t0, estatisticas_jogo		# caso opção digitada for 1, exibe a matriz de navios
	li t0, 4				# carrega número 4 para comparação
	beq a0, t0, reiniciar_jogo		# reinicializa as matrizes
	la t0, loop_jogo			#
	jalr x0, 0(t0)				# exibe opções para o usuário
fim_jogo:
	li a7, 10
	ecall
	
.include "PromptFunctions.asm"			# Contém funções de interface com o usuário 
.include "GameFunctions.asm"	 		# -----> Contém funções do menu principal do jogo (da main) <-------
.include "MatrixFunctions.asm"			# Contém funções de manipulação de matrizes
.include "CharMatrixFunctions.asm"		# Contém funções para manipulação das matrizes de caracteres
.include "VectorFunctions.asm"			# Contém funções para manipulação dos vetores de tiros
.include "StringFunctions.asm"			# Contém funções para manipulação de strings
.include "InsertionTests.asm" 			# x-x

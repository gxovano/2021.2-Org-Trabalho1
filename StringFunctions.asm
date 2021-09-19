#####
 # string_tupla2(a2): gera a representação em string de uma tupla de 2 caracteres
 	# a2: ponteiro para tupla (vetor de coordenadas (x,y))
string_tupla2:
	la t0, buffer			# carrega ponteiro do buffer (definido em "Main.asm")
	li t2, 0			# zera registrador de composição de tupla
	lw t3, 4(a2)			# carrega 1º elemento da tupla
	addi t3, t3, 48			# adiciona 48 para completar o código ASCII
	add t2, t2, t3			# adiciona caracter à string - SEGUNDO
	slli t2, t2, 8			# desloca 1 byte à esquerda
	addi t2, t2, 44			# adiciona o caracter de virgula - TERCEIRO
	slli t2, t2, 8			# desloca 1 byte à esquerda
	lw t3, 0(a2)			# carrega 1º elemento da tupla
	addi t3, t3, 48			# adiciona 48 para completar o código ASCII
	add t2, t2, t3			# adiciona caracter à string - QUARTO
	sw t2, 0(t0)			# descarrega para buffer
	ret
	
#####
 # adiciona_ao_buffer_pointers(a2): adiciona o ponteiro do conteúdo ao buffer de ponteiros
 	# a2: ponteiro para o conteúdo
adiciona_ao_buffer_pointers:	
	la t0, buffer_pointer		# carrega endereço do buffer
	lw t1, 0(t0)			# carrega primeiro item do buffer (contador)
	slli t2, t1, 2			# multiplica por 4
	add t2, t2, t0			# adiciona ao endereço de memória
	sw a2, 0(t2)			# armazena ponteiro
	addi t1, t1, 1			# incrementa contador do buffer
	sw t1, 0(t0)			# armazena conteúdo da variável
	ret
	
#####
 # limpa_buffer_pointers(a2): remove o conteúdo do buffer de caracteres
 	# a2: ponteiro para o conteúdo	
limpa_buffer_pointers:
	la t0, buffer_pointer 		# carrega endereço de memória do buffer
	lw t1, 0(t0)			# carrega valor do contador do buffer
	li t2, 0			# contador de ponteiros
	lw t3, buffer_vazio		# 
loop_limpa_buffer_ponteiros:	
	addi t0, t0, 4			# endereço + 4
	addi t2, t2, 1			# incrementa contador de ponteiros
	sw t3, 0(t0)			# armazena string vazia no buffer
	ble t2, t1, loop_limpa_buffer_ponteiros	# se contador menor que nro de ponteiros, continua
	ret

#####
 # print_buffer_pointers(): imprime o conteúdo do buffer
print_buffer_pointers:
	addi sp, sp, -4			# reserva espaço na pilha de execução
	sw ra, 0(sp)			# salva RA na pilha de execução
	la t0, buffer_pointer		# carrega ponteiro do buffer
	lw t1, 0(t0)			# carrega contador do buffer de ponteiros
	li t2, 0			# inicializa contador de loops
loop_print_bp:		
	addi t0, t0, 4			# incrementa em 4 o ponteiro do buffer
	addi t2, t2, 1			# incrementa em 1 o contador do buffer
	lw a0, 0(t0)			# carrega o ponteiro do buffer
	beqz a0, fim_print_bp		# se o ponteiro for nulo, pula para o fim
	li a7, 4			# carrega código da ecall PrintString
	ecall				#
	ble t2, t1, loop_print_bp	# enquanto o número de ponteiros for menor ou igual ao contador do buffer, continua
fim_print_bp:
	lw ra, 0(sp)			# recupera o RA da pilha
	addi sp, sp, 4			# reseta a pilha
	ret

#####
 # adiciona_int_ao_buffer_words(a2): adiciona um inteiro ao buffer de conteudos
 	# a2: numero inteiro
 	# -> a0: endereço de armazenamento
adiciona_int_ao_buffer_words:
	la t0, buffer_words		# carrega endereço do buffer
	lw t1, 0(t0)			# carrega contador de words
	addi t3, a2, 48			# adiciona 48 para completar ASCII
#	slli t3, t3, 16			# adiciona "\0\0"
	slli t2, t1, 2			# contador * 4
	addi t6, t0, 4
	add a0, t2, t6			# incrementa endereço
	sw t3, 0(a0)			# salva int no buffer
	addi t1, t1, 1			# incrementa contador
	sw t1, 0(t0)			# salva contador
	ret

#####
 # limpa_buffer_words(a2): remove o conteúdo do buffer de caracteres
 	# a2: ponteiro para o conteúdo	
limpa_buffer_words:
	la t0, buffer_words 		# carrega endereço de memória do buffer
	lw t1, 0(t0)			# carrega valor do contador do buffer
	li t2, 0			# contador de ponteiros
	lw t3, buffer_vazio		# 
loop_limpa_buffer_conteudo:	
	addi t0, t0, 4			# endereço + 4
	addi t2, t2, 1			# incrementa contador de ponteiros
	sw t3, 0(t0)			# armazena string vazia no buffer
	ble t2, t1, loop_limpa_buffer_conteudo	# se contador menor que nro de ponteiros, continua
	ret

	
	

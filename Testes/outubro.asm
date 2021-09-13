.data
campo:   		.space 100   # 
.align 2
navios:                 .word 3 1 5 1 1 0 5 2 2 0 1 6 4 #valores para iniciar as embarca��es
letras:                 .asciz "abcdefgh"
arrume_sobreposicao :   .asciz "Arrume a Sobreposicao\n"
msg_erro_nav:          .asciz "navio fora de limites\n"

erro_direcao:           .asciz "Direcao invalida\n"
.text

main:
       la t4, letras
       la t5, navios
       lw t6, 0(t5)   # n = *np
       addi t5,t5,1

       li t1,0
       li t2,100
       la t3, campo
       li a0, '~'
for1:
      beq t1,t2, endfor1
      #sw a0,0(t3)
      lbu a0,0(t3)
      addi t3,t3,4
      addi t1,t1,1
      j for1

endfor1:
      li t1,0

for2:
	beq t1,t6, endfor2
     	lbu a0, 0(t5)   # dir
     	addi t5,t5,4
     	lbu a1, 0(t5)   # size
     	addi t5,t5,4
     	lbu a2, 0(t5)   # x
     	addi t5,t5,4
     	lbu a3, 0(t5)   # y
     	addi t5,t5,4
     	jal ra, insere_navios
     	addi t1,t1,1
     	j for2

endfor2:
	li a7, 10   # sai sem codigo de retorno
	ecall    # fim do programa

insere_navios:
	li t1,1
     	bne a1, t1, endif0 # if dir == 1     caso vertical
     	add t1, a3, a1   # x + size
      	li t2, 10
      	bge t1, t2, else1   # if not (y + size >= 10)
       	blt a3, zero, else1  # if not (y < 0)
       	blt a2, zero, else1  # if not (x < 0)
      	bge a2, t2, else1   # if not (x >= 10)
      	# letra em t3, i em t1, x em a2 e y em a3
      	li t1, 0
	for3:
		bge t1,a2, endfor3   #   i < size
      		la t5, campo
      		add t5, t5, a2   #  m + x
      		add t2, a3, t1   # y + i
      		slli t4, t2, 3     # 8 * (y + i)
      		slli t2, t2, 1     # 2 * (y + i)
      		add t5, t5, t4   # m + x + 8*(y + i)
      		add t5, t5, t2   # m + x + 10*(y + i)
      		lbu t2, 0(t5)
      		li t4, '~'
      		bne t2, t3, else7    #  if (m[x][y + i] == '~') ...
      		sb t3, 0(t5)     # m[x][y+i] = letra
      		j endif7
	else7:
      		la a0, arrume_sobreposicao # printf("\n\nArrume a Sobreposi��o  %d %d %d %d\n ", dir, size, x, y);
      		li a7, 4
     		ecall
      		#j endfor1    # break
      		j endfor3
	endif7:
      		addi t1, t1, 1
     		j for3
	endfor3:
     		#j endif1
     		j endfor3
	else1:
     		la a0, msg_erro_nav # printf("\nnavio vertical fora de limites.......)
      		li a7, 4
     		ecall
	endif1:
	endif0:
      		bne a1, zero, endif2   # if dir == 0    caso horizontal
      	 	add t1, a2, a1   # x + size
       		li t2, 10
       		bge t1, t2, else3   # if not (x + size >= 10)
        	blt a2, zero, else3  # if not (x < 0)
        	blt a3, zero, else3  # if not (y < 0)
       		bge a3, t2, else3   # if not (y >= 10)
       		# letra em t3, i em t1, x em a2 e y em a3
       		li t1, 0   #  i = 0
	for4:
       		bge t1,a2, endfor4   #   i < size
       		la t5, campo
       		add t5, t5, a2   #  m + x
       		add t5, a5, t1   # m + x + i
       		slli t4, a3, 3     # 8 * y
       		slli t2, a3, 1     # 2 * y
       		add t5, t5, t4   # m + x + i + 8*y
       		add t5, t5, t2   # m + x + i + 10*y
       		lbu t2, 0(t5)
       		li t4, '~'
       		bne t2, t3, else8    #  if (m[x+i][y] == '~') ...
       		sb t3, 0(t5)     # m[x+i][y] = letra
       		j endif8
	else8:
      		la a0, arrume_sobreposicao # printf("\n\nArrume a Sobreposi��o  %d %d %d %d\n ", dir, size, x, y);
      		li a7, 4
     		ecall
     		
      		j endfor2    # break
	endif8:
      		addi t1, t1, 1
     		j for4
	endfor4:
     		j endif3
	else3:
     		la a0, msg_erro_nav # printf("\nnavio vertical fora de limites.......)
      		li a7, 4
     		ecall
	endif3:
	endif2:
    		li t1, 1
    		ble a0, t1, endif5   #   if dir > 1  eh erro
    		la a0, erro_direcao # printf("\ndire��o inv�lida: %d\n", dir);
    		li a7, 4
     		ecall
	endif5:
    		#j ra   # fim de insere_navio
    		la a0, erro_direcao # printf("\nnavio vertical fora de limites.......)
      		li a7, 4
     		ecall


###
 # Inclus�o dos prompts para o usu�rio
# Estat�sticas:
msg_qtd_total_tiros: .asciz "\nTotal de tiros: "
msg_qtd_tiros_certeiros: .asciz "\nTiros certeiros ao alvo: "
msg_qtd_tiros_nagua: .asciz "\nTiros n'�gua: "
buffer_vazio: .ascii "\0\0\0\0"
msg_erro_invalida: .asciz "A posi��o da embarca��o � inv�lida.\n"
msg_erro_saliente: .asciz "A embarca��o est� saliente � dimens�o da matriz.\n"
digite_linha_tiro: .asciz "\nDigite a linha onde ser� o disparo: "
digite_coluna_tiro: .asciz "\nDigite a coluna onde ser� o disparo: "
msg_ultimo_tiro: .asciz "\n �ltimo tiro: "
 # Prompts do menu
msg_escolhe_string: .asciz "Digite um n�mero de 1 a 5 para escolher uma disposi��o de embarca��es: "
menu: .asciz "Escolha a pr�xima a��o:\n1 - Exibir matriz de navios\n2 - Efetuar tiro\n3 - Exibir estatisticas\n4 - Reiniciar jogo\n5 - Sair"
menu_footer: .asciz "\n---------------------------------\n"
divisor: .asciz "\n---------------------------------"
 # Montagem da matriz
cabecalho_matriz_navios: .asciz " _____________________ \n|   MATRIZ DE NAVIOS  |\n|_____________________|\n  0 1 2 3 4 5 6 7 8 9\n"
cabecalho_matriz_tiro: .asciz " _____________________ \n|   MATRIZ DE TIRO    |\n|_____________________|\n  0 1 2 3 4 5 6 7 8 9\n"
rodape_matriz_navios: .asciz "101010101010101010101\n"
separador_prompt: .asciz "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"


###
 # Inclus�o dos prompts para o usu�rio
digite_orientacao: .asciz "\nEscolha a orienta��o: 0 - horizontal ; 1 - vertical "
digite_comprimento: .asciz "\nEscolha o tamanho do navio: "
digite_linha: .asciz "\nDigite a coordenada vertical do navio: "
digite_coluna: .asciz "\nDigite a coordenada horizontal do navio: "
msg_erro_invalida: .asciz "A posi��o da embarca��o � inv�lida.\n"
msg_erro_saliente: .asciz "A embarca��o est� saliente � dimens�o da matriz.\n"
digite_linha_tiro: .asciz "\nDigite a linha onde ser� o disparo: "
digite_coluna_tiro: .asciz "\nDigite a coluna onde ser� o disparo: "
 # Prompts do menu
menu: .asciz "-----------\nEscolha a pr�xima a��o:\n1 - Exibir matriz de navios\n2 - Efetuar tiro\n3 - Exibir estatisticas\n4 - Inserir navio\n5 - Reiniciar jogo\n6 - Sair"
menu_footer: .asciz "\n-----------\n"
 # Montagem da matriz
cabecalho_matriz_navios: .asciz " _____________________ \n|   MATRIZ DE NAVIOS  |\n|_____________________|\n  0 1 2 3 4 5 6 7 8 9\n"
cabecalho_matriz_tiro: .asciz " _____________________ \n|   MATRIZ DE TIRO    |\n|_____________________|\n  0 1 2 3 4 5 6 7 8 9\n"
rodape_matriz_navios: .asciz "101010101010101010101\n"
separador_prompt: .asciz "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
prompt_continuar: .asciz "\nSenta o dedo no Enter pra continuar..."

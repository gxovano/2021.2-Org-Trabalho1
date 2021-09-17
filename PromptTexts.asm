###
 # Inclusão dos prompts para o usuário
digite_orientacao: .asciz "\nEscolha a orientação: 0 - horizontal ; 1 - vertical "
digite_comprimento: .asciz "\nEscolha o tamanho do navio: "
digite_linha: .asciz "\nDigite a coordenada vertical do navio: "
digite_coluna: .asciz "\nDigite a coordenada horizontal do navio: "
msg_erro_invalida: .asciz "A posição da embarcação é inválida.\n"
msg_erro_saliente: .asciz "A embarcação está saliente à dimensão da matriz.\n"
 # Prompts do menu
menu: .asciz "-----------\nEscolha a proxima ação:\n1 - Exibir matriz de navios\n2 - Efetuar tiro\n3 - Exibir estatisticas\n4 - Inserir navio\n5 - Sair"
menu_footer: .asciz "\n-----------\n"
 # Montagem da matriz
cabecalho_matriz_navios: .asciz " _____________________ \n|   MATRIZ DE NAVIOS  |\n|_____________________|\n  0 1 2 3 4 5 6 7 8 9\n"
cabecalho_matriz_tiro: .asciz " _____________________ \n|   MATRIZ DE TIRO    |\n|_____________________|\n  0 1 2 3 4 5 6 7 8 9\n"
rodape_matriz_navios: .asciz "101010101010101010101\n"

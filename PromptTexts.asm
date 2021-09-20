###
 # Inclusão dos prompts para o usuário
# Estatísticas:
msg_qtd_total_tiros: .asciz "\nTotal de tiros: "
msg_qtd_tiros_certeiros: .asciz "\nTiros certeiros ao alvo: "
msg_qtd_tiros_nagua: .asciz "\nTiros n'água: "
buffer_vazio: .ascii "\0\0\0\0"
msg_erro_invalida: .asciz "A posição da embarcação é inválida.\n"
msg_erro_saliente: .asciz "A embarcação está saliente à dimensão da matriz.\n"
digite_linha_tiro: .asciz "\nDigite a linha onde será o disparo: "
digite_coluna_tiro: .asciz "\nDigite a coluna onde será o disparo: "
msg_ultimo_tiro: .asciz "\n Último tiro: "
 # Prompts do menu
msg_escolhe_string: .asciz "Digite um número de 1 a 5 para escolher uma disposição de embarcações: "
menu: .asciz "Escolha a próxima ação:\n1 - Exibir matriz de navios\n2 - Efetuar tiro\n3 - Exibir estatisticas\n4 - Reiniciar jogo\n5 - Sair"
menu_footer: .asciz "\n---------------------------------\n"
divisor: .asciz "\n---------------------------------"
 # Montagem da matriz
cabecalho_matriz_navios: .asciz " _____________________ \n|   MATRIZ DE NAVIOS  |\n|_____________________|\n  0 1 2 3 4 5 6 7 8 9\n"
cabecalho_matriz_tiro: .asciz " _____________________ \n|   MATRIZ DE TIRO    |\n|_____________________|\n  0 1 2 3 4 5 6 7 8 9\n"
rodape_matriz_navios: .asciz "101010101010101010101\n"
separador_prompt: .asciz "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"


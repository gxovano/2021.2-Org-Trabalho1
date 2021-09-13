#include <stdio.h>
#define endl "\n"

int m[10][10]; // variavel global


void insere_embarcacoes(int dir, int size, int x, int y){

  if (dir == 1){ //if
    if(x < 10 && y < 10){ // funcao nova
        if ( x + size - 1 < 10 && x > -1 ){ //if2
            for (int i = 0; i < size; i++)//for3

                if (m[x + i][y] == 0){//for4
                    m[x + i][y] = 1;
                
                }else{
                    printf("\n\nOcorre sobreposição nos navios!\n ");
                    break;
                }
            
        }else{
            printf("\nO navio extrapola as dimensões da matriz  10x10\n");
        }
    }
    else{
        printf("A posição do navio é inválida\n");
    }
  }

  if (dir == 0){
    if(x < 10 && y < 10){
        if ( y + size - 1 < 10 && y > -1 ){
            for (int i = 0; i < size; i++)
                if (m[x][y + i] == 0){
                    m[x][y + i] = 1;
                

                }else{
                
                    printf("\n\nOcorre sobreposição nos navios!\n ");
                    break;
            
                }

        }else{
           printf("\nO navio extrapola as dimensões da matriz  10x10\n");
        }
    }
    else{
        printf("A posição do eixo do navio é inválida\n"); // funcao nova
    }
  }

  

  if (dir > 1){
    printf("\ndireção inválida: %d\n", dir);
  }
}

void imprime_matriz(int n){
  
  printf("\n");
  printf("  0 1 2 3 4 5 6 7 8 9 \n");
  for (int y = 0; y < n; y++)
  {
    printf("%d ", y);
    for (int x = 0; x < n;x++)
      printf("%d ", m[y][x]);
    printf(endl);
  }
}

/* int darTiro( int m[10][10]) {

    int linha=0;
    int coluna=0;

    printf("\n");
    printf("Linha: ");
    scanf("%d", &linha);

    printf("Coluna: ");
    scanf(" %d", &coluna);

   if (m[linha][coluna] == 1) {

        m[linha][coluna] = 9;   
        printf("Você acertou o tiro *-* \n");
        return 1;

    } 
   
    else {
        m[linha][coluna] = 5;
       
       printf("Você errou o tiro\n");
    }
  
} */

int darTiro( int m[10][10]) {

    int a, b;

    printf("\n");
    printf("Linha: ");
    scanf("%d", &a);

    printf("Coluna: ");
    scanf("%d", &b);

    if (m[a][b] == 1) {
        m[a][b] = 9;   /* atribui um valor 9 para dizer que acertou */
        printf("Você acertou o tiro *-* \n");
        return 1;
    } else {
        if(m[a][b] == 9 || m[a][b] == 5) {
            printf("Você já atirou nessa posição\n");
            return 0;
        }
        m[a][b] = 5;
        printf("Você errou o tiro\n");
        return 0;
    }
}

int main(){
    int n;
    int tiro[100];
    int acertos=0;
    int tam=0;

  

    scanf("%d", &n);

    for (int i = 0; i <= 9; i++){
        for (int j = 0; j <= 9; j++){
            m[i][j] = 0;
        }
    }

    for (int i = 0; i < n; i++){
        int dir, size, x, y;
        scanf("%d %d %d %d", &dir, &size, &x, &y);
        tam += size;
        insere_embarcacoes(dir, size, x, y);
    }

    while(tam > 0){
        printf("==== VOCÊ TEM APENAS %d tentativas ====\n", tam);

        imprime_matriz(10);

       
        if(darTiro(m)){
           acertos++;
        }
        else{
            printf("tente novamente\n");
        } 
        tam --;
    } 
        
    
    printf("\n Acabou a partida parceiro\nVocê acertou %d Navios!\n", acertos);
    
    return 0;
}

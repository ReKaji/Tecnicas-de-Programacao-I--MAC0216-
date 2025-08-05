#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>

long double ep3CalculaEntropiaShannon(char *string, int base){
    long double shannon = 0;
    char *ja_lidos=(char *)malloc(strlen(string)+1);
    int i =0;
    int indice_ja_lidos=0;
    for (int i=0; i<strlen(string)-1;i++) ja_lidos[i]=0;
    while (i<strlen(string)){
        int ja_lido=0;
        //laço que verifica se um caractere igual já foi lido.
        for (int j=0; j<=indice_ja_lidos;j++){
            if (string[i]== ja_lidos[j]){
                    ja_lido=1;
                    break;
                }
                else ja_lido=0;
        }
        //se nenhum caractere igual já foi lido, calcula pi.log(pi) na base de entrada.
        if (ja_lido==0){
            double prob = 1.0;
            for (int k=i+1; k<strlen(string);k++){
                if (string[k]==string[i]) prob++;
            }
            ja_lidos[indice_ja_lidos]=string[i];
            indice_ja_lidos++;
            prob = prob/strlen(string);
            shannon+= prob * (log(prob)/log(base));
        }
        i++;
    }
    //faz a troca de sinal da entropia de Shannon. (pois a fórmula possui um menos antes da somatória.)
    shannon=shannon*(-1);
    free(ja_lidos);
    return shannon;
}


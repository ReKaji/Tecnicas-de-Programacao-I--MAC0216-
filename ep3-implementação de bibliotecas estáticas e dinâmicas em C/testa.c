#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#include "hashliza.h"
#include "shannon.h"

int main() {

// Primeiros testes - testando a as funções relacionadas à formação do hash, com o VetorMágico fixo.
    printf("Primeiramente, testaremos as funções relacionadas à formação do hash, com  VetorMágico fixo (o vetor apresentado no EP1):");
    printf("\n");
    printf("\n");
    //entrada1:Ola mundo!
    char entrada[] = "Ola mundo!";
    int mag[257] = {122, 77, 153, 59, 173, 107, 19, 104, 123, 183, 75, 10,114, 236, 106, 83, 117, 16, 189, 211, 51, 231, 143, 118, 248, 148, 218,245, 24, 61, 66, 73, 205, 185, 134, 215, 35, 213, 41, 0, 174, 240, 177,195, 193, 39, 50, 138, 161, 151, 89, 38, 176, 45, 42, 27, 159, 225, 36,64, 133, 168, 22, 247, 52, 216, 142, 100, 207, 234, 125, 229, 175, 79,220, 156, 91, 110, 30, 147, 95, 191, 96, 78, 34, 251, 255, 181, 33, 221,139, 119, 197, 63, 40, 121, 204, 4, 246, 109, 88, 146, 102, 235, 223,214, 92, 224, 242, 170, 243, 154, 101, 239, 190, 15, 249, 203, 162, 164,199, 113, 179, 8, 90, 141, 62, 171, 232, 163, 26, 67, 167, 222, 86, 87,71, 11, 226, 165, 209, 144, 94, 20, 219, 53, 49, 21, 160, 115, 145, 17,187, 244, 13, 29, 25, 57, 217, 194, 74, 200, 23, 182, 238, 128, 103,140, 56, 252, 12, 135, 178, 152, 84, 111, 126, 47, 132, 99, 105, 237,186, 37, 130, 72, 210, 157, 184, 3, 1, 44, 69, 172, 65, 7, 198, 206,212, 166, 98, 192, 28, 5, 155, 136, 241, 208, 131, 124, 80, 116, 127,202, 201, 58, 149, 108, 97, 60, 48, 14, 93, 81, 158, 137, 2, 227, 253,68, 43, 120, 228, 169, 112, 54, 250, 129, 46, 188, 196, 85, 150, 6, 254,180, 233, 230, 31, 76, 55, 18, 9, 32, 82, 70}; 
    int tam = 32;
    char * p1 = ep1Passo1Preenche(entrada);
    char * p2 = ep1Passo2XOR(p1,mag,&tam);
    char *p3 = ep1Passo3Comprime(p2, tam,mag);
    char *p4= ep1Passo4Hash(p3);
    char *resultado=ep1Passo4HashEmHexa(p4);
    printf ("O hash produzido pela entrada <Ola mundo!> é: ");
    for (int i= 0; i< 32; i++){
        printf("%c", resultado[i]);
    }
    printf("\n");
    
    if (strcmp(resultado, "7ea2319be0d038908161b4e8c26bfc7a") == 0) {
        printf("A saída produzida é correta.\n");
    } else {
        printf("A saída produzida é incorreta.\n");
    }

    printf("\n");
    
    //entrada2: Eu sou seu pai!
    char entrada1[] = "Eu sou seu pai!";
    int tam1 = 32;
    char * p11 = ep1Passo1Preenche(entrada1);
    char * p21 = ep1Passo2XOR(p11,mag,&tam1);
    char *p31 = ep1Passo3Comprime(p21, tam1,mag);
    char *p41= ep1Passo4Hash(p31);
    char *resultado1=ep1Passo4HashEmHexa(p41);
    printf ("O hash produzido pela entrada <Eu sou seu pai!> é: ");
    for (int i= 0; i< 32; i++){
        printf("%c", resultado1[i]);
    }
    printf("\n");
    
    if (strcmp(resultado1, "7599d088e2b5b0cb1497123787d33a65") == 0) {
        printf("A saída produzida é correta.\n");
    } else {
        printf("A saída produzida é incorreta.\n");
    }

    printf("\n");
     
    //entrada3: bhfdshcsavghsduiwfhipwdquidvyudhodhjdwyugdqoihdwqigwdui	fdwiuhiefgu
    char entrada2[] = "bhfdshcsavghsduiwfhipwdquidvyudhodhjdwyugdqoihdwqigwdui	fdwiuhiefgu";
    int tam2 = 96;
    char * p12 = ep1Passo1Preenche(entrada2);
    char * p22 = ep1Passo2XOR(p12,mag,&tam2);
    char *p32 = ep1Passo3Comprime(p22, tam2,mag);
    char *p42= ep1Passo4Hash(p32);
    char *resultado2=ep1Passo4HashEmHexa(p42);
    printf ("O hash produzido pela entrada <bhfdshcsavghsduiwfhipwdquidvyudhodhjdwyugdqoihdwqigwdui	fdwiuhiefgu> é: ");
    for (int i= 0; i< 32; i++){
        printf("%c", resultado2[i]);
    }
    printf("\n");
    
    if (strcmp(resultado2, "478408c98eb2f9f5ff211e6b433bdcc2") == 0) {
        printf("A saída produzida é correta.\n");
    } else {
        printf("A saída produzida é incorreta.\n");
    }

    printf("\n");
   
    //entrada4: oiddyegyuegowgiufwgyfguwefhweuog
    char entrada3[] = "oiddyegyuegowgiufwgyfguwefhweuog";
    int tam3 = 48;
    char * p13 = ep1Passo1Preenche(entrada3);
    char * p23= ep1Passo2XOR(p13,mag,&tam3);
    char *p33 = ep1Passo3Comprime(p23, tam3,mag);
    char *p43= ep1Passo4Hash(p33);
    char *resultado3=ep1Passo4HashEmHexa(p43);
    printf ("O hash produzido pela entrada <oiddyegyuegowgiufwgyfguwefhweuog> é: ");
    for (int i= 0; i< 32; i++){
        printf("%c", resultado3[i]);
    }
    printf("\n");
    
    if (strcmp(resultado3, "797038c6d5ee7a52e12d818fa8f2cc4c") == 0) {
        printf("A saída produzida é correta.\n");
    } else {
        printf("A saída produzida é incorreta.\n");
    }

    printf("\n");
 
    //entrada5: oi tudo bem?
    char entrada4[] = "oi tudo bem?";
    int tam4 = 32;
    char * p14 = ep1Passo1Preenche(entrada4);
    char * p24 = ep1Passo2XOR(p14,mag,&tam4);
    char *p34 = ep1Passo3Comprime(p24, tam4,mag);
    char *p44= ep1Passo4Hash(p34);
    char *resultado4=ep1Passo4HashEmHexa(p44);
    printf ("O hash produzido pela entrada <oi tudo bem?> é: ");
    for (int i= 0; i< 32; i++){
        printf("%c", resultado4[i]);
    }
    printf("\n");
    
    if (strcmp(resultado4, "313e7306df53c7f755ed805848c31727") == 0) {
        printf("A saída produzida é correta.\n");
    } else {
        printf("A saída produzida é incorreta.\n");
    }

    printf("\n");
    printf("---------------------------------------------------------------------------\n");
    printf("\n");
  
  // Free memory
    free(p1);
    free(p2);
    free(p3);
    free(p4);
    free(resultado);
    free(p11);
    free(p21);
    free(p31);
    free(p41);
    free(resultado1);
    free(p12);
    free(p22);
    free(p32);
    free(p42);
    free(resultado2);
    free(p13);
    free(p23);
    free(p33);
    free(p43);
    free(resultado3);
    free(p14);
    free(p24);
    free(p34);
    free(p44);
    free(resultado4);

//Agora testaremos a função que gera o vetor com 256 inteiros, entre 0 a 255, sem repetição.
    printf("Agora testaremos a função que gera o vetor com 256 inteiros, entre 0 a 255, sem repetição:");

    printf("\n");
    printf("\n");
    //seed1:41
    printf("O vetor produzido pela seed 41 é:");
    printf("\n");
    int *vetor41=ep3CriaVetorMagico(41);
    for (int i = 0; i< 256; i++){
        printf("%d",vetor41[i] );
        printf(" ");
    } 
    printf("\n");

    for (int i=0; i<256; i++){
        for (int j=i+1; j<256; j++){
            if (vetor41[i]==vetor41[j]) {
                printf("Há dois números repetidos no vetor.");
                break;
            }
        }
        if (i==255) printf("Não há repetição de valores no vetor.");
    }    
    printf("\n");
    
    for (int i =0; i<256; i++){
        if (vetor41[i]>255 || vetor41[i]<0){
            printf("Há um valor que é menor que 0 ou que é maior que 255.");
            break;
        }
        if (i==255) printf("Todos os valores do vetor estão entre 0 e 255.");
    }
    printf("\n");
    int teste41[257]= {109,178,76,77,250,75,85,182,196,46,114,23,49,45,65,39,119,7,228,254,176,95,106,10,26,130,28,107,141,156,207,79,71,73,103,157,255,43,203,113,66,252,158,132,35,22,139,20,60,102,127,70,128,1,98,236,142,187,137,78,215,208,151,62,150,105,56,172,53,165,48,88,96,247,198,61,80,160,51,222,159,238,237,4,110,33,19,74,5,82,253,146,161,58,217,241,218,12,121,55,192,111,234,197,242,37,153,206,97,212,167,174,179,40,199,220,125,163,143,69,231,129,189,30,84,112,3,171,145,89,185,177,50,251,92,83,21,226,117,223,246,186,27,42,233,9,87,229,64,123,249,149,232,34,164,86,194,122,214,118,136,94,11,52,131,239,224,68,93,15,14,169,41,38,148,90,134,202,8,227,63,235,230,24,81,221,209,116,152,216,195,36,240,140,188,13,200,32,6,155,173,67,144,204,211,57,47,44,181,210,0,18,190,59,248,205,120,168,2,154,135,138,124,180,244,17,16,126,193,243,29,191,170,101,183,25,219,245,91,72,175,54,166,184,100,133,213,201,104,31,147,115,225,108,99,162};
    for (int i=0; i<256;i++){
        if (vetor41[i]!=teste41[i]){
            printf("A saída para o vetor produzido pela seed 41 está incorreta.");
            break;
        }
        if (i=255) printf("A saída para o vetor produzido pela seed 41 está correta.");
    }
    free(vetor41);
    printf("\n");
    printf("\n");
    //seed2: 15
    printf("O vetor produzido pela seed 15 é:");
    printf("\n");
    int *vetor15=ep3CriaVetorMagico(15);
    for (int i = 0; i< 256; i++){
        printf("%d",vetor15[i] );
        printf(" ");
    } 
    printf("\n");

    for (int i=0; i<256; i++){
        for (int j=i+1; j<256; j++){
            if (vetor15[i]==vetor15[j]) {
                printf("Há dois números repetidos no vetor.");
                break;
            }
        }
        if (i==255) printf("Não há repetição de valores no vetor.");
    }    
    printf("\n");
    
    for (int i =0; i<256; i++){
        if (vetor15[i]>255 || vetor15[i]<0){
            printf("Há um valor que é menor que 0 ou que é maior que 255.");
            break;
        }
        if (i==255) printf("Todos os valores do vetor estão entre 0 e 255.");
    }
    printf("\n");
    int teste15[257]= {213,102,61,135,80,17,178,31,144,171,48,96,236,98,193,141,67,132,1,109,152,117,0,177,8,56,116,197,13,218,2,148,42,20,71,123,51,215,38,100,55,18,198,248,160,9,125,161,119,21,22,200,64,181,139,14,143,142,162,186,233,53,192,91,57,247,110,255,240,175,128,130,184,151,249,93,174,156,63,25,40,44,238,136,224,246,39,208,4,179,176,191,121,105,86,7,180,150,16,157,50,77,113,69,45,154,27,131,99,239,107,52,243,155,167,76,49,32,23,59,190,216,185,252,43,127,36,120,226,227,203,207,124,84,165,65,90,3,101,79,235,87,106,5,188,212,253,10,205,41,24,34,140,81,199,202,72,166,254,15,204,62,133,244,74,196,206,214,146,112,11,245,164,209,58,60,168,103,35,234,201,33,54,225,73,108,189,68,169,211,231,114,118,83,221,26,149,229,232,159,237,95,241,70,251,78,104,222,172,137,122,94,220,138,85,37,129,153,29,219,30,134,92,173,250,194,46,228,28,210,47,163,170,126,182,187,147,75,111,217,89,12,230,82,66,6,242,145,88,183,97,115,19,158,223,195};
    for (int i=0; i<256;i++){
        if (vetor15[i]!=teste15[i]){
            printf("A saída para o vetor produzido pela seed 15 está incorreta.");
            break;
        }
        if (i=255) printf("A saída para o vetor produzido pela seed 15 está correta.");
    }
    free(vetor15);
    printf("\n");
    printf("\n");
    //seed3:88
    printf("O vetor produzido pela seed 88 é:");
    printf("\n");
    int *vetor88=ep3CriaVetorMagico(88);
    for (int i = 0; i< 256; i++){
        printf("%d",vetor88[i] );
        printf(" ");
    } 
    printf("\n");

    for (int i=0; i<256; i++){
        for (int j=i+1; j<256; j++){
            if (vetor88[i]==vetor88[j]) {
                printf("Há dois números repetidos no vetor.");
                break;
            }
        }
        if (i==255) printf("Não há repetição de valores no vetor.");
    }    
    printf("\n");
    
    for (int i =0; i<256; i++){
        if (vetor88[i]>255 || vetor88[i]<0){
            printf("Há um valor que é menor que 0 ou que é maior que 255.");
            break;
        }
        if (i==255) printf("Todos os valores do vetor estão entre 0 e 255.");
    }
    printf("\n");
    int teste88[257]= {113,7,197,202,45,130,31,193,135,243,50,251,176,229,93,222,16,11,154,119,117,107,34,102,73,212,218,217,245,75,224,186,21,14,60,52,207,195,40,1,190,216,230,27,182,246,38,80,166,158,17,192,44,10,0,155,227,231,196,252,210,236,49,161,89,162,110,136,138,126,56,36,78,253,54,15,41,247,25,42,147,122,118,146,188,167,51,108,213,100,219,81,99,114,120,139,58,72,145,177,77,88,185,228,65,248,163,29,13,244,112,67,83,187,128,30,123,63,175,26,133,181,12,104,254,91,156,6,24,69,68,95,201,148,226,101,28,179,96,19,94,35,168,111,5,131,206,87,235,134,233,241,125,173,55,86,22,223,200,174,76,234,171,240,46,23,180,70,203,194,153,132,152,140,43,137,90,61,160,127,32,209,71,105,142,232,66,157,208,143,129,85,225,82,4,239,215,150,37,115,205,191,64,8,59,255,242,109,39,47,74,184,189,172,169,198,237,103,18,106,3,221,92,151,53,204,62,250,116,214,164,121,141,199,33,220,211,79,2,159,124,249,238,9,20,84,183,97,178,98,149,57,48,165,144,170};
    for (int i=0; i<256;i++){
        if (vetor88[i]!=teste88[i]){
            printf("A saída para o vetor produzido pela seed 88 está incorreta.");
            break;
        }
        if (i=255) printf("A saída para o vetor produzido pela seed 88 está correta.");
    }
    printf("\n");
    printf("\n");
    free(vetor88);
    printf("---------------------------------------------------------------------------\n");
    printf("\n");
//Agora testaremos a função que calcula a entropia de Shannon.
    printf("Agora testaremos a função que calcula o entropia de Shannon:");
    printf("\n");
    printf("\n");

    //entrada 1:araraquara 
    //base1=2
    //saída esperada: 1.685475
    printf("entrada: araraquara");
    printf("\n");
    char* string = "araraquara";
    int base =2;
    long double shannon = ep3CalculaEntropiaShannon(string, base);
    printf("Entropia de Shannon na base 2 = ");
    printf("%Lf", shannon);
    printf("\n");
    if (shannon-1.685475<0.00001) printf("A entropia de Shannon possui o valor esperado.\n");
    else printf("A entropia de Shannon não possui o valor esperado.\n");
    printf("\n");
  
    //entrada2:araraquara
    //base2:10
    //saída esperada: 0.507379
    printf("entrada: araraquara");
    printf("\n");
    char* string1 = "araraquara";
    int base1 =10;
    long double shannon1 = ep3CalculaEntropiaShannon(string1, base1);
    printf("Entropia de Shannon na base 10 = ");
    printf("%Lf", shannon1);
    printf("\n");
    if (shannon1-0.507379<0.00001) printf("A entropia de Shannon possui o valor esperado.\n");
    else printf("A entropia de Shannon não possui o valor esperado.\n");
    printf("\n");
    //entrada3: Ola mundo!
    //base3:2
    //saída esperada: 3.321928
    printf("entrada: Ola mundo!");
    printf("\n");
    char* string2 = "Ola mundo!";
    int base2=2;
    long double shannon2 = ep3CalculaEntropiaShannon(string2, base2);
    printf("Entropia de Shannon na base 2 = ");
    printf("%Lf", shannon2);
    printf("\n");
    if (shannon2-3.321928<0.00001) printf("A entropia de Shannon possui o valor esperado.\n");
    else printf("A entropia de Shannon não possui o valor esperado.\n");
    printf("\n");
    
    //entrada4: itaquaquecetuba
    //base4:2
    //saída esperada: 2.872906
    
    printf("entrada: itaquaquecetuba");
    printf("\n");
    char* string3 = "itaquaquecetuba";
    int base3 =2;
    long double shannon3 = ep3CalculaEntropiaShannon(string3, base3);
    printf("Entropia de Shannon na base 2 = ");
    printf("%Lf", shannon3);
    printf("\n");
    if (shannon3-2.872906<0.00001) printf("A entropia de Shannon possui o valor esperado.\n");
    else printf("A entropia de Shannon não possui o valor esperado.\n");
    printf("\n");
    
    //entrada5: jurubatuba
    //base5:2
    //saída esperada: 2.446439
    printf("entrada: jurubatuba");
    printf("\n");
    char* string4 = "jurubatuba";
    int base4 =2;
    long double shannon4 = ep3CalculaEntropiaShannon(string4, base4);
    printf("Entropia de Shannon na base 2 = ");
    printf("%Lf", shannon4);
    printf("\n");
    if (shannon4-2.446439<0.00001) printf("A entropia de Shannon possui o valor esperado.\n");
    else printf("A entropia de Shannon não possui o valor esperado.\n");

    return 0;
}



#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>

char * ep1Passo1Preenche(char *s)
{
// verificação de erros:
    //verifica se a string recebida é correta.
    if (s==NULL) return NULL;
    for (int i=0; i< strlen(s); i++){
        if (s[i]<0 || s[i]> 127) return NULL;
    }

//fim da verificação de erros.
    int tamanho = strlen (s);
    int resto = (16 - (tamanho%16)) %16;
    int lenvet=tamanho+resto+1;
    char *saida=(char *)malloc(lenvet);
    for (int i=0; i<tamanho; i++){
        int asc=(int)s[i];
        saida[i]=asc;
    }
    if (resto!=0){   
        for (int j =0; j<resto; j++){
            saida[tamanho+j]=resto;
        }
    }
    saida[lenvet - 1] = '\0';
    return saida;
}

char * ep1Passo2XOR(char *saida1, int *mag, int*tam){


//verificação de erros:
    //verifica se o mag é um vetor mágico.
    int vetor[257];
    for (int i =0; i<256; i++){
        vetor[i]=257;
    }
    for (int j=0; j<256; j++){
        int k = 0;
        while (k< j){
            if (mag[j]==vetor[k]) return NULL;
            k++;
        }
        vetor[j]= mag[j];
    }
    //verifica se a string de entrada é correta.
    if (saida1==NULL) return NULL;
    for (int i=0; i< strlen(saida1); i++){
        if (saida1[i]<0 || saida1[i]> 127) return NULL;
    }
    //verifica o ponteiro de inteiro.
    if (tam == NULL) return NULL;

//fim da verificação de erros.

    int n = strlen(saida1);
    n=n/16;
    char *novobloco=(char *)malloc((17));
    for (int i = 0; i < 16; i++) {
    novobloco[i] = 0;
    }
    int novoValor=0;
    for (int i=0; i<n; i++){
        for (int j=0; j<16; j++){
            novoValor= (mag[(unsigned char)saida1[(i*16)+j]^(unsigned int)novoValor])^(unsigned char) novobloco[j];
            novobloco[j]= (unsigned int) novoValor;
        }
    }
    char *saida2=(char *)malloc((*tam)+1);
    for (int j=0; j<n*16;j++){
        saida2[j]=saida1[j];
    }
    for (int i =0; i<16; i++ ){
        saida2[i+(n*16)]= novobloco[i];
    }
    free(novobloco);


    return saida2;
}

char * ep1Passo3Comprime(char *saida2, int tam2, int *mag){

//verificação de erros:
    //verifica se mag é um vetor mágico.
    int vetor[257];
    for (int i =0; i<256; i++){
        vetor[i]=257;
    }
    for (int j=0; j<256; j++){
        int k = 0;
        while (k< j){
            if (mag[j]==vetor[k]) return NULL;
            k++;
        }
        vetor[j]= mag[j];
    }
    //verifica se a string de entrada não é nula.
    if (saida2==NULL) return NULL;
    //verifica se o inteiro possui o tamanho esperado.                                                                                                                                      
    if (tam2 < 0 || tam2 > 2147483647) return NULL;                                                                                                                                                                                                                                                                                                                                             


//fim da verificação de erros.

    char *saida3=(char *)malloc(49);
    for (int i=0; i<48;i++) saida3[i]=0;
    for (int i=0; i< tam2/16; i++){
        for (int j=0; j<16; j++){
            saida3[16+j]=(unsigned char)saida2[i*16+j];
            saida3[2*16+j]= (saida3[16+j]^saida3[j]);}
        int temp=0;
        for (int a=0; a< 18; a++){
            for (int k=0; k<48; k++){
                temp=saida3[k]^mag[(unsigned char)temp];
                saida3[k]=temp;}
            temp=(temp+a)%256; }
    }
    return saida3;
}

char * ep1Passo4Hash(char *saida3){
//verificação de erros:
    if (saida3==NULL) return NULL;
//fim da verificação de erros.   

    char *saida4=(char *)malloc(17);
    for (int i=0; i<16;i++){
        saida4[i]=(unsigned char)saida3[i];
    }
    return saida4;
}

char * ep1Passo4HashEmHexa(char *saida4){
//verificação de erros:
    if (saida4==NULL) return NULL;
//fim da verificação de erros.  
    char *saidanova=(char *)malloc(33);
    for (int i=0; i<16; i++){
        int div= (int)(unsigned char)saida4[i]/16;
        int resto= (int)(unsigned char)saida4[i]%16;

        //transforma o número hexadecimal em seu correspondente ascii. Se for maior que 9 será um caractere, se for menor um número.
        if (div>9){
            div+=87;
            saidanova[(i*2)]= (unsigned char)div;
        }
        else{
            div+=48;
            saidanova[(i*2)]=(unsigned char)div;
        }
        if (resto>9){
            resto+=87;
            saidanova[(i*2)+1]= (unsigned char)resto;
        }
        else{
            resto+=48;
            saidanova[(i*2)+1]=(unsigned char)resto;
        }
    }
    saidanova[32]='\0';
    return saidanova;
}

int * ep3CriaVetorMagico(int seed){
//verificação de erros:
    if (seed< -2147483648 || seed>2147483647) return NULL;
//fim da verificação de erros.  
    srand(seed);
    int *vemag=(int *)malloc(257* sizeof(int));
    for (int i=0; i<256;i++){
        vemag[i]=257;
    }
    for (int j=0; j<256; j++){
        int existe =0;
        while (vemag[j]==257){
            int random= rand() % 256; //operação que garante que os números sejam de 0 a 255
            //laço que vê se o número já está no vetor, para que não haja nenhuma repetição.
            for (int k=0; k<j; k++){
                if (vemag[k]==random){
                    existe=1;
                    break;
                }
                else existe=0;
            }
            if (existe!=1)  vemag[j]=random;
        }

    }
    return vemag;
}
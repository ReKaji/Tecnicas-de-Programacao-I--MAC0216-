/*!
 * \brief Função que dada uma string devolve uma sequência de bytes correspondentes aos caracteres da string em ascii. 
 * Caso a string tenha um tamanho múltiplo de 16, a função devolverá a sequência de bytes correspondentes aos caracteres da string em ascii.
 * Caso a string tenh um tamanho que não é múltiplo de 16, a função devolverá a sequência de bytes correspondentes aos caracteres da string em ascii e,
 * adicionará a quantidade de caracteres necessárias para que a saída tenha um tamanho múltiplo de 16, sendo tais caracteres iguais ao resto da divisão entre 
 * tamanho da string e 16.
 * \param s: Uma string de qualquer tamanho.
 * \return Um vetor de caracteres que corresponde a uma sequência de bytes correspondentes aos caracteres da string em ascii e que seja múltiplo de 16.
 */
char * ep1Passo1Preenche(char *s);

/*!
 * \brief Função que dada uma sequência de caracteres de tamanho múltiplo de 16, retorna tal sequência concatenada com uma nova sequência de 16 
 * caracteres,sendo tais caracteres gerados a partir de um vetor de 256 bytes com números de 0 a 255 (e sem repetição) e o vetor de entrada.
 * \param saida1: Um vetor de caracteres com tamanho múltiplo de 16.
 * \param mag: Um vetor de inteiros com 256 bytes, com números de 0 a 255 em ordem aleatória e sem repetição.
 * \param tam: Um inteiro que indica o tamanho do vetor de saída da função, ou seja, o tamanho do vetor saida1 + 16.
 * \return Um vetor de caracteres que corresponde a entrada "saida1" concatenada com uma nova sequência de 16 bytes.
 */

char * ep1Passo2XOR(char *saida1, int *mag, int*tam);

/*!
 * \brief Função que dada uma sequência de caracteres de tamanho arbitrário múltiplo de 16, retorna uma sequência de caracteres de tamanho igual a 48,
 * formada a partir do vetor de entrada e um vetor de 256 bytes com números de 0 a 255 (e sem repetição).
 * \param saida2: Um vetor de caracteres com tamanho múltiplo de 16.
 * \param mag: Um vetor de inteiros com 256 bytes, com números de 0 a 255 em ordem aleatória e sem repetição.
 * \param tam2: Um inteiro que indica o tamanho do vetor "saida2" de entrada da função.
 * \return Um vetor de caracteres de tamanho 48 gerado a partir da entrada "saida2" e do vetor de inteiros "mag".
 */

char * ep1Passo3Comprime(char *saida2, int tam2, int *mag);

/*!
 * \brief Função que dada uma sequência de caracteres de tamanho 48, retorna uma sequência de tamanho 16, correspondente aos 16 primeiros caracteres da entrada.
 * \param saida3: Um vetor de caracteres de tamanho 48.
 * \return Um vetor de caracteres de tamanho 16, correspondente aos 16 primeiros caracteres da entrada.
 */

char * ep1Passo4Hash(char *saida3);


/*!
 * \brief Função que dada uma sequência de caracteres de tamanho 16, devolve um vetor de 32 caracteres correpondentes aos caracteres da entrada em hexadecimal.
 * Note que, para cada caracter de entrada, serão necessários duas posições do vetor de saída, para que seja feita a representação em hexadecimal.
 * \param saida4: Um vetor de caracteres com tamanho 16.
 * \return Um vetor de caracteres de tamanho 32 correpondente aos valores do vetor de entrada em hexadecimal.
 */

char * ep1Passo4HashEmHexa(char *saida4);

/*!
 * \brief Função que dada um inteiro, gera um vetor de 256 inteiros, com números de 0 a 255 em ordem pseudo-aleatória e sem repetição.
 * \param seed: Um inteiro que será responsável por gerar os números de forma pseudo-aleatória.
 * \return Um vetor de 256 inteiros, com números de 0 a 255 em ordem pseudo-aleatória e sem repetição.
 */
int * ep3CriaVetorMagico(int seed);
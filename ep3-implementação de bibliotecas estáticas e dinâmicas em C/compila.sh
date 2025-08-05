#!/bin/bash

#Função que confere se houve algum erro no comando anterior. Se der algum erro, o script retorna o valor 1.
function ver_erro {
    if [ $? -ne 0 ]; then
        exit 1
    fi
}


#Compila o arquivo hashliza.c, criando o arquivo objeto hashliza.o, que será utilizado para a criação da biblioteca estática libhashliza.a.
gcc -Wall -c -o hashliza.o hashliza.c
ver_erro

#Cria a biblioteca estática libhashliza.a a partir do arquivo objeto hashliza.o. Além disso, o comando > /dev/null serve para não mostrar a mensagem de saída do comando na saída padrão. 
ar -rcv libhashliza.a hashliza.o > /dev/null
ver_erro

#Compila o arquivo shannon.c, criando o arquivo objeto shannon.o, que será utilizado para a criação da biblioteca dinâmica libshannon.so. 
#O -FPIC serve para gerar um código independente de posição.
gcc -c -fPIC -o shannon.o shannon.c  
ver_erro

#Cria a biblioteca dinâmica libshannon.so a partir do arquivo objeto shannon.o. 
gcc -o libshannon.so -shared shannon.o 
ver_erro

#Edita a variável de ambiente LD_LIBRARY_PATH, fazendo com que o executável procure as bibliotecas dinâmicas no diretório atual.
export LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH
ver_erro

#Compila o arquivo testa.c, vinculando-o com as bibliotecas libhashliza.a, libshannon.o e lm (biblioteca matemática necessária para fazer a operação logarítmica).
gcc -o testa testa.c libhashliza.a -L. -lshannon -lm -Wl,-rpath=$PWD
ver_erro



#Gera o arquivo de configuração do doxygen. Além disso, o comando > /dev/null serve para não mostrar a mensagem de saída do comando na saída padrão.
doxygen -g > /dev/null
ver_erro

#Modifica o arquivo de configuração do doxygen, fazendo com que a configuração GENERATE_LATEX seja igual a NO.
linhacerta=$(grep -n "GENERATE_LATEX         =" "Doxyfile"|cut -f 1 -d ":")
ver_erro
sed -i "${linhacerta}s@GENERATE_LATEX         = YES.*@GENERATE_LATEX         = NO@" Doxyfile
ver_erro

#Modifica o arquivo de configuração do doxygen, fazendo com que a configuração OUTPUT_LANGUAGE seja igual a Brazilian.
linhacerta=$(grep -n "OUTPUT_LANGUAGE        =" "Doxyfile"|cut -f 1 -d ":")
ver_erro
sed -i "${linhacerta}s@OUTPUT_LANGUAGE        = English.*@OUTPUT_LANGUAGE        = Brazilian@" Doxyfile
ver_erro

#Modifica o arquivo de configuração do doxygen, fazendo com que a configuração OPTIMIZE_OUTPUT_FOR_C seja igual a YES.
linhacerta=$(grep -n "OPTIMIZE_OUTPUT_FOR_C  =" "Doxyfile"|cut -f 1 -d ":")
ver_erro
sed -i "${linhacerta}s@OPTIMIZE_OUTPUT_FOR_C  = NO.*@OPTIMIZE_OUTPUT_FOR_C  = YES@" Doxyfile
ver_erro

#Modifica o arquivo de configuração do doxygen, fazendo com que a configuração GENERATE_TREEVIEW seja igual a YES.
linhacerta=$(grep -n "GENERATE_TREEVIEW      =" "Doxyfile"|cut -f 1 -d ":")
ver_erro
sed -i "${linhacerta}s@GENERATE_TREEVIEW      = NO.*@GENERATE_TREEVIEW      = YES@" Doxyfile
ver_erro

#Modifica o arquivo de configuração do doxygen, fazendo com que a configuração INPUT seja igual a hashliza.h e shannon.h. Ou seja, faz com que as interfaces das bibliotecas sejam os imputs 
#do arquivo doxygen.
linhacerta=$(grep -n "INPUT                  =" "Doxyfile"|cut -f 1 -d ":")
ver_erro
sed -i "${linhacerta}s@INPUT                  =.*@INPUT                  = hashliza.h shannon.h@" Doxyfile
ver_erro

#Modifica o arquivo de configuração do doxygen, fazendo com que a configuração EXTRACT_ALL seja igual a YES.
linhacerta=$(grep -n "EXTRACT_ALL            =" "Doxyfile"|cut -f 1 -d ":")
ver_erro
sed -i "${linhacerta}s@EXTRACT_ALL            = NO.*@EXTRACT_ALL            = YES@" Doxyfile
ver_erro

#Roda o doxygen com o Doxyfile modificado. Além disso, o comando > /dev/null serve para não mostrar a mensagem de saída do comando na saída padrão.
doxygen Doxyfile > /dev/null

exit 0
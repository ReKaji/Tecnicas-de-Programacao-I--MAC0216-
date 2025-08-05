#!/bin/bash

# AUTOR:

# Renan Ryu Kajihara; númeroUSP:14605762; email:renankajihara@usp.br


# DESCRIÇÃO:

# O programa a seguir, desenvolvido em bash script, funciona como um chat entre usuários logados em um mesmo computador,
# na qual tais usuários podem trocar mensagem entre si, por meio de um servidor.


# COMO EXECUTAR:

# O programa pode ser executados de dois modos,sendo eles o modo cliente e o modo servidor.

# Para executar o programa no modo cliente, deve-se rodas tal comando no terminal:
# ./ep2.sh cliente

# Para executar o programa no modo servidor, deve-se rodar tal comando no terminal:
# ./ep2.sh servidor


# TESTES:

# Se o programa for executado no modo cliente, o programa aceitará os seguintes comandos:
# create <usuario> <senha> : tal comando cria um usuário de nome=<usuario> e senha=<senha>
# passwd <usuario> <antiga> <nova>: tal comando muda a senha antiga=<antiga> do usuário de nome=<usuario> pra a senha nova=<nova>
# login <usuario> <senha>: tal comando faz com que o usuário de nome=<usuario> e senha=<senha> logue no servidor
# quit: tal comando interrompe a execução do programa.

# Após o usuario estar logado, por meio do comando login, o programa aceita apenas tais comandos:
# list: tal comando lista os nomes dos usuários que estão logados no servidor.
# msg <dest> <mensagem>: tal comando mostra a mensagem=<mensagem> ao usuario de nome=<dest>
# logout: tal comando faz com que o usuario deslogue do servidor, podendo utilizar os comandos anteriormente descritos.
# quit:tal comando interrompe a execução do programa.

# Se o programa for executado no modo servidor, o programa aceitará os seguintes parâmetros:
# list: tal parâmetro lista os nomes dos usuários que estão logados no servidor.
# time: tal parâmetro mostra quanto tempo faz com que o servidor foi iniciado, em segundos.
# reset: tal parâmetro "reinicia" o servidor, removendo todos os usuários logados e criados até então.
# quit: interrompe a execução do programa.

# Para testar o programa é recomendado fazer uma simulação de um chat entre dois terminais. Para isso, é recomendado seguir tal passo-a-passo:

# 1) Abrir três terminais, na qual em dois terminais o programa deverá ser executada no modo cliente e 
# em um deles deverá ser executado no modo servidor;
# 2) Em ambos os terminais em que o modo cliente estiver sendo executado, deve-se criar  um usuario, por meio do comando create, 
# e com nome de usuário e senha arbitrários;
# 3) Para testar o comando passwd, pode-se trocar a senha de um dos usuários, utilizando o comando passwd da forma descrita anteriormente;
# 4) Em seguida, é recomendado que ambos os usuários criados sejam logados no servidor, por meio do comando login, que deverá ser executado em
# ambos os terminais que estiverem no modo cliente;
# 5) Para testar o comando list, deve-se rodar o comando list nos três terminai. Dessa forma, todos os terminais devem mostrar os usuários logados 
# no passo anterior;
# 6) Para testar o comando time, deve-se rodar o comando time no terminal em que o programa está sendo executado no modo servidor. Dessa forma, o programa
# deve mostrar um número, que representa há quantos segundos o servidor foi iniciado;
# 7) Para testar o comando msg, deve-se, em um dos terminais que está rodando o programa em modo cliente, rodar o comando msg como descrito acima, na qual
# dest deve ser o nome de usuário que foi criado e está logado no outro terminal que está rodando no modo cliente. O comando deve mostrar no terminal em que o 
# usuário possui nome=<dest> a mensagem escrita no outro terminal;
# 8) Para testar o comando logout, deve-se rodá-lo em ambas os terminais que estão rodando o programa no modo cliente, e rodar o comando list no terminal que está
# rodando o programa em modo servidor. Note que, o comando list não irá produzir nenhuma saída, pois após o logout, não há nenhum usuário logado;
# 9) Por último, deve-se rodar o comando quit em todos os terminais. Tal comando deve encerrar o processo em todos os terminais.


# DEPENDÊNCIAS:

# Para rodar o programa a seguir é necessário que a máquina que irá executá-lo possua o Sistema Operacional Linux ou Unix. 
# Dessa forma, o Bash será o shell padrão do Sistema Operacional da máquina.

# O programa foi testado com sucesso em um computador que possui: Sistema Operacional Ubuntu 20.04.4 LTS; Kernel Linux 5.14.0-1059-oem;
# Arquitetura x86-64; memória de 15,4 GB; e processador Intel Core i7.




# se o programa for executado com 0 ou mais de 1 parâmetro, é informado como é o uso do programa.
if [ $# -ne 1 ]; then
    echo "Uso: $0 <servidor|cliente>"
    exit 1
fi

url="https://api.telegram.org/bot6389913663:AAEjsVLBJ88WhGRcCyZjzQqdaUv3u8q_dIQ/sendMessage?chat_id=6239155465"

# se o programa for executado no modo cliente, ele entra nesse laço:
if [ $1 == "cliente" ]; then
    printf "cliente> "
    read linha
    comandoc=$(echo $linha | cut -f 1 -d ' ')
    #laço que lê os comandos, até o comando for igual a quit.
    while [ $comandoc != "quit" ]; do
        #Instrução condicional que cria o usuário. Dá erro se o usuário já existir.
        if [ $comandoc == "create" ]; then
            existe=false
            user=$(echo $linha | cut -f 2 -d ' ')
            pas=$(echo $linha | cut -f 3 -d ' ')

            if [ -e "/tmp/usuarios.txt" ]; then
                for i in $(cat "/tmp/usuarios.txt"); do
                    if [ $i == $user ]; then
                        echo "ERRO"
                        existe=true
                        break
                    fi
                done

                if [ $existe != true ]; then
                    echo $user >> "/tmp/usuarios.txt"
                    echo $pas >> "/tmp/senhas.txt"
                fi

            else
                echo $user >> "/tmp/usuarios.txt"
                echo $pas >> "/tmp/senhas.txt"
            fi

        #Instrução condicional que muda a senha antiga do usuário para a senha nova. Dá erro se o usuário não existir ou se a senha velha passada for errada.
        elif [ $comandoc == "passwd" ]; then
            erros=true
            user=$(echo $linha | cut -f 2 -d ' ')
            antiga=$(echo $linha | cut -f 3 -d ' ')
            nova=$(echo $linha | cut -f 4 -d ' ')

            if [ -e "/tmp/usuarios.txt" ]; then
                for i in $(cat "/tmp/usuarios.txt"); do
                    if [ $i == $user ]; then
                        erros=false
                        linhacerta=$(grep -n $user "/tmp/usuarios.txt"|cut -f 1 -d ":")
                        break
                    fi
                done
                if [ $erros = true ]; then
                    echo "ERRO"
                elif [ $(sed -n $linhacerta"p" "/tmp/senhas.txt") != $antiga ]; then
                    echo "ERRO"
                    erros=true
                    dia=$(date|cut -f 2 -d " ")
                    mes=$(date|cut -f 3 -d " ")
                    ano=$(date|cut -f 4 -d " ")
                    hora=$(date|cut -f 5 -d " ")
                    echo "$user errou a senha no dia $dia de $mes de $ano às $hora" > "/tmp/errosenha.txt"
                else
                    sed -i "s/$antiga/$nova/" "/tmp/senhas.txt"
                fi
            else
                echo "ERRO"
            fi

        #Instrução condicional que loga o usuário no servidor. Dá erro se a senha for errada ou se o usuário não existir.
        elif [ $comandoc == "login" ] ; then
            user=$(echo $linha | cut -f 2 -d ' ')
            pas=$(echo $linha | cut -f 3 -d ' ')
            erros=true
            if [ -e "/tmp/usuarios.txt" ]; then
                for i in $(cat "/tmp/usuarios.txt"); do
                    if [ $i == $user ]; then
                        erros=false
                        linhacerta=$(grep -n $user "/tmp/usuarios.txt"|cut -f 1 -d ":")
                        break
                    fi
                done
                if [ $erros == true ]; then
                    echo "ERRO"
                elif [ $(sed -n $linhacerta"p" "/tmp/senhas.txt") != $pas ]; then
                    echo "ERRO"
                    erros=true
                    dia=$(date|cut -f 2 -d " ")
                    mes=$(date|cut -f 3 -d " ")
                    ano=$(date|cut -f 4 -d " ")
                    hora=$(date|cut -f 5 -d " ")
                    echo "$user errou a senha no dia $dia de $mes de $ano às $hora" > "/tmp/errosenha.txt"
                elif [ -e "/tmp/logados.txt" ]; then
                    for i in $(cat "/tmp/logados.txt"); do
                        if [ $i == $user ]; then
                            echo "ERRO"
                            erros=true
                            break
                        fi
                    done
                fi
            else 
                echo "ERRO"
                erros=true
            fi

            if [ $erros == false ]; then
                logado=true
                dia=$(date|cut -f 2 -d " ")
                mes=$(date|cut -f 3 -d " ")
                ano=$(date|cut -f 4 -d " ")
                hora=$(date|cut -f 5 -d " ")
                echo "$user logou com sucesso no dia $dia de $mes de $ano às $hora" > "/tmp/logou.txt"

                echo $user >> "/tmp/logados.txt"
                printf "cliente> "
                
                comandoc=$(echo $linha | cut -f 1 -d ' ')
                while [ $logado == true ]; do
                    if [ -e "/tmp/$user" ]; then
                        read mensagem < /tmp/$user                        
                        echo $mensagem > /dev/tty
                        rm /tmp/$user
                        printf "cliente> "
                    fi
                done &
                segundoplanodois=$!

                read linha
                comandoc=$(echo $linha | cut -f 1 -d ' ')

                #laço em que, após logado, lê os comandos passador pelo cliente.
                while [ $comandoc != "logout" ]; do
                    #Instrução condicional que lista os usuários logados no servidor.
                    if [ $comandoc == "list" ]; then
                        for i in $(cat "/tmp/logados.txt" ); do
                            echo $i
                        done
                    #Instrução condicional que manda uma mensagem ao usuários destino. Dá erro se o usuário destino não estiver logado no servidor.
                    elif [ $comandoc == "msg" ]; then
                        errosm=true
                        dest=$(echo $linha | cut -f 2 -d ' ')
                        mens=$(echo $linha | cut -d " " -f 3- )
                        if [ -e "/tmp/logados.txt" ]; then
                            for i in $(cat "/tmp/logados.txt"); do
                                if [ $i == $dest ]; then
                                    errosm=false
                                    linhacerta=$(grep -n $user "/tmp/usuarios.txt"|cut -f 1 -d ":")
                                    break
                                fi
                            done
                        fi
                        if [ $errosm == true ]; then
                            echo "ERRO"
                        else
                            echo "[Mensagem do $user]: $mens" > /tmp/$dest
                        fi
                    #Instrução condicional que saí do programa.
                    elif [ $comandoc == "quit" ]; then
                        kill -15 $segundoplanodois
                        logado=false
                        dia=$(date|cut -f 2 -d " ")
                        mes=$(date|cut -f 3 -d " ")
                        ano=$(date|cut -f 4 -d " ")
                        hora=$(date|cut -f 5 -d " ")
                        echo "$user deslogou com sucesso no dia $dia de $mes de $ano às $hora" > "/tmp/deslogou.txt"
                        linhacerta=$(grep -n $user "/tmp/logados.txt"|cut -f 1 -d ":")
                        sed -i "${linhacerta}d" "/tmp/logados.txt"
                        exit 0  

                    else
                        echo "ERRO"
                    fi

                    printf "cliente> "
                    read linha
                    comandoc=$(echo $linha | cut -f 1 -d ' ')
                done
                # desloga o usuário do servidor, se o comando for igual a logout.
                dia=$(date|cut -f 2 -d " ")
                mes=$(date|cut -f 3 -d " ")
                ano=$(date|cut -f 4 -d " ")
                hora=$(date|cut -f 5 -d " ")
                echo "$user deslogou com sucesso no dia $dia de $mes de $ano às $hora" > "/tmp/deslogou.txt"
                linhacerta=$(grep -n $user "/tmp/logados.txt"|cut -f 1 -d ":")
                if [ -e "/tmp/$user" ]; then
                    rm /tmp/$user
                fi
                sed -i "${linhacerta}d" "/tmp/logados.txt"
                kill -15 $segundoplanodois
            fi
        else
            echo "ERRO" 
        fi
        printf "cliente> "
        read linha
        comandoc=$(echo $linha | cut -f 1 -d ' ')
    done
    logado=false
    

    exit 0
fi

#Instrução condicional que executa o programa no modo servidor.
if [ $1 == "servidor" ]; then
    #laço que manda ao bot do telegram todos os usuários logados, com intervalo de tempo de 1 minuto.
    while [ true ]; do
        if [ -e "/tmp/logados.txt" ]; then
            if [ -s "/tmp/logados.txt" ]; then
                curl -s --data "text=Usuários conectados:" "$url" 1>/dev/null > "/tmp/lixo.txt"
                for i in $(cat "/tmp/logados.txt"); do
                    curl -s --data "text=$i" "$url" 1>/dev/null > "/tmp/lixo.txt"
                done
            fi
        fi
        sleep 60    
    done &
    segundoplanoum=$!

    tzeros=$(date|cut -f 5 -d " "|cut -f 3 -d ":")
    tzerom=$(date|cut -f 5 -d " "|cut -f 2 -d ":")
    tzeroh=$(date|cut -f 5 -d " "|cut -f 1 -d ":")
    #laço que manda ao bot do telegram as mensagens de erro de senha, login com sucesso e logout com sucesso, assim que os usuários errarem a senha ou
    # logarem com sucesso ou deslogarem com sucesso, respectivamente.
    while [ true ]; do
        if [ -e "/tmp/errosenha.txt" ]; then
            if [ -s "/tmp/errosenha.txt" ]; then
                read tele < "/tmp/errosenha.txt"
                curl -s --data "text=$tele" "$url" 1>/dev/null
                rm "/tmp/errosenha.txt"
            fi
        fi
        if [ -e "/tmp/logou.txt" ]; then
            if [ -s "/tmp/logou.txt" ]; then
                read tele < "/tmp/logou.txt"
                curl -s --data "text=$tele" "$url" 1>/dev/null
                rm "/tmp/logou.txt"
            fi
        fi
        if [ -e "/tmp/deslogou.txt" ]; then
            if [ -s "/tmp/deslogou.txt" ]; then
                read tele < "/tmp/deslogou.txt"
                curl -s --data "text=$tele" "$url" 1>/dev/null
                rm "/tmp/deslogou.txt"
            fi
        fi
    done &
    segundoplanotres=$!

    printf "servidor> "
    read linha
    comandos=$(echo $linha | cut -f 1 -d ' ')
    #laço que lê os comandos no modo servidor até o comando quit for passado via entrada padrão.
    while [ $comandos != "quit" ]; do
        #Instrução condicional que lista os usuários logados.
        if [ $comandos == "list" ]; then
            if [ -e "/tmp/logados.txt" ]; then
                for i in $(cat "/tmp/logados.txt"); do
                    echo $i
                done
            fi
        #Instrução condicional que imprime na saída padrão o intervalo de tempo em que o servidor foi criado, em segundos.
        elif [ $comandos == "time" ];then
            tnovos=$(date|cut -f 5 -d " "|cut -f 3 -d ":")
            tnovom=$(date|cut -f 5 -d " "|cut -f 2 -d ":")
            tnovoh=$(date|cut -f 5 -d " "|cut -f 1 -d ":")
            if [ $tzeroh -eq $tnovoh ]; then
                if [ $tzerom -eq $tnovom ]; then
                    t=$(echo "$tnovos-$tzeros"|bc -l)
                    echo $t
                else 
                    if [ $tzeros -le $tnovos ]; then
                        min=$(echo "$tnovom-$tzerom"|bc -l)
                        min=$(echo "$min*60"|bc -l)
                        seg=$(echo "$tnovos-$tzeros"|bc -l)
                        echo $(echo "$min+$seg"|bc -l)
                    else
                        min=$(echo "$tnovom-$tzerom"|bc -l)
                        min=$(echo "$min*60"|bc -l)
                        seg=$(echo "$tzeros-$tnovos"|bc -l)
                        echo $(echo "$min-$seg"|bc -l)
                    fi
                fi
            elif [ $tzeroh -gt $tnovoh ]; then
                if [ $tzerom -eq $tnovom ]; then
                    if [ $tzeros -le $tnovos ]; then
                        t=$(echo "((($tnovoh+24)-$tzeroh)*3600)+($tnovos-$tzeros)"|bc -l)
                        echo $t
                    else 
                        t=$(echo "((($tnovoh+24)-$tzeroh)*3600)-($tzeros-$tnovos)"|bc -l)
                        echo $t
                    fi
                elif [ $tzerom -gt $tnovom ]; then
                    if [$tzeros -le $tnovos]; then
                        t=$(echo "((($tnovoh+24)-$tzeroh)*3600)+($tnovos-$tzeros)-(($tzerom-$tnovom)*60)"|bc -l)
                        echo $t
                    else 
                       t=$(echo "((($tnovoh+24)-$tzeroh)*3600)-($tzeros-$tnovos)-(($tzerom-$tnovom)*60)"|bc -l)
                        echo $t
                    fi
                elif [ $tzerom -lt $tnovom ]; then
                    if [$tzeros -le $tnovos]; then
                        t=$(echo "((($tnovoh+24)-$tzeroh)*3600)+($tnovos-$tzeros)+(($tnovom-$tzerom)*60)"|bc -l)
                        echo $t
                    else 
                       t=$(echo "((($tnovoh+24)-$tzeroh)*3600)-($tzeros-$tnovos)+(($tnovom-$tzerom)*60)"|bc -l)
                        echo $t
                    fi
                fi
            else
                if [ $tzerom -eq $tnovom ]; then
                    if [ $tzeros -le $tnovos ]; then
                        t=$(echo "((($tnovoh-$tzeroh)*3600)+($tnovos-$tzeros)"|bc -l)
                        echo $t
                    else 
                        t=$(echo "((($tnovoh-$tzeroh)*3600)-($tzeros-$tnovos)"|bc -l)
                        echo $t
                    fi
                elif [ $tzerom -gt $tnovom ]; then
                    if [ $tzeros -le $tnovos ]; then
                        t=$(echo "((($tnovoh-$tzeroh)*3600)+($tnovos-$tzeros)-(($tzerom-$tnovom)*60)"|bc -l)
                        echo $t
                    else 
                       t=$(echo "((($tnovoh-$tzeroh)*3600)-($tzeros-$tnovos)-(($tzerom-$tnovom)*60)"|bc -l)
                        echo $t
                    fi
                elif [ $tzerom -lt $tnovom ]; then
                    if [ $tzeros -le $tnovos ]; then
                        t=$(echo "((($tnovoh-$tzeroh)*3600)+($tnovos-$tzeros)+(($tnovom-$tzerom)*60)"|bc -l)
                        echo $t
                    else 
                       t=$(echo "((($tnovoh-$tzeroh)*3600)-($tzeros-$tnovos)+(($tzerom-$tnovom)*60)"|bc -l)
                        echo $t
                    fi
                fi
            fi
        #Instrução condicional que remove todos os usuários conectados no servidor.
        elif [ $comandos == "reset" ]; then
            if [ -e "/tmp/usuarios.txt" ]; then
                rm "/tmp/usuarios.txt"
            fi
            if [ -e "/tmp/senhas.txt" ]; then
                rm "/tmp/senhas.txt"
            fi
            if [ -e "/tmp/logados.txt" ]; then
                rm "/tmp/logados.txt"
            fi
            if [ -e "/tmp/lixo.txt" ]; then
                rm "/tmp/lixo.txt"
            fi       
        else 
            echo "ERRO"
        fi
        printf "servidor> "
        read linha
        comandos=$(echo $linha | cut -f 1 -d ' ')
    done
    # saí do programa, removendo todos os usuários conectados no servidor.
    if [ -e "/tmp/usuarios.txt" ]; then
        rm "/tmp/usuarios.txt"
    fi
    if [ -e "/tmp/senhas.txt" ]; then
        rm "/tmp/senhas.txt"
    fi
    if [ -e "/tmp/logados.txt" ]; then
        rm "/tmp/logados.txt"
    fi
    if [ -e "/tmp/lixo.txt" ]; then
        rm "/tmp/lixo.txt"
    fi       
    kill -15 $segundoplanoum
    kill -15 $segundoplanotres
    exit 0
fi




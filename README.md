# Projeto: Técnicas de Programação I (MAC0216) — Portfólio de exercícios

Este repositório reúne os trabalhos práticos desenvolvidos durante a disciplina "Técnicas de Programação I" (MAC0216). Cada pasta contém um exercício (EP) com código, scripts de compilação/execução e documentação mínima. O objetivo deste README é explicar, em linguagem técnica e objetiva, o que foi implementado em cada exercício, quais tecnologias foram utilizadas e quais competências foram exercitadas — com foco em demonstrar capacidades relevantes para vagas de engenharia de software.

## Como navegar neste repositório
- `ep1-função de hash em Assembly/` — implementação em Assembly e scripts auxiliares (Python) para experimentação.
- `ep2-sistema de chat (cliente e servidor) e bash script/` — cliente/servidor e script para demonstração.
- `ep3-implementação de bibliotecas estáticas e dinâmicas em C/` — bibliotecas em C, utilitários de hashing e compressão, e scripts de compilação.

## Instruções rápidas (exemplos)
Use Python 3, GCC e Bash disponíveis em ambientes Linux/UNIX. Exemplos mínimos:

```bash
# EP1: executar script Python que acompanha a implementação Assembly
python3 "ep1-função de hash em Assembly/EP1.py"

# EP2: executar o script de demonstração (cliente/servidor)
bash "ep2-sistema de chat (cliente e servidor) e bash script/ep2.sh"

# EP3: compilar e testar as bibliotecas/implementações em C
bash "ep3-implementação de bibliotecas estáticas e dinâmicas em C/compila.sh"
```

## Projetos (EPs)

EP1 — Função de hash em Assembly
- Objetivo: projetar e implementar uma função de hash escrita em Assembly e integrá-la a código de nível superior para testes e validação.
- O que foi feito: implementação em Assembly (`EP1.s`), scripts de suporte e um pequeno driver em Python (`EP1.py`) para gerar vetores de teste, validar saídas e medir propriedades básicas (colisões simples, distribuição).
- Tecnologias e conceitos: Assembly (sintaxe dependente do montador usado), Python 3 para testes/automação, conhecimento de representação binária, otimização em registradores, manipulação de bytes e endianness.
- Competências demonstradas: pensamento em baixo nível (memória/registradores), integração entre linguagens, escrita de testes automatizados e análise de qualidade de funções de hash.

EP2 — Sistema de chat (cliente e servidor) + script
- Objetivo: implementar um protótipo de comunicação em rede com cliente e servidor, e criar um script bash para facilitar demonstrações e testes locais.
- O que foi feito: implementação do fluxo de cliente/servidor (scripts ou binários conforme a pasta), gerenciamento de conexões, troca de mensagens e um script `ep2.sh` que automatiza a execução em terminais separados para demonstração.
- Tecnologias e conceitos: programação de sockets (modelo cliente/servidor), concorrência básica (threads/processos leves ou multiplexação), bash scripting para automação, conceitos de protocolo e formatos de mensagem.
- Competências demonstradas: engenharia de rede básica (sockets), depuração de sistemas distribuídos simples, automação de experimentos, atenção à robustez de I/O e tratamento de erros.

EP3 — Implementação de bibliotecas estáticas e dinâmicas em C
- Objetivo: construir bibliotecas em C que exponham utilitários de hashing e compressão (Shannon), compilar versões estáticas e dinâmicas, e escrever um pequeno programa de teste.
- O que foi feito: código-fonte em `hashliza.c/.h` e `shannon.c/.h`, scripts de compilação (`compila.sh`) para gerar bibliotecas e exemplos de uso, e um arquivo `testa.c` para validar a integração.
- Tecnologias e conceitos: C (ISO C), criação de bibliotecas estáticas (`.a`) e dinâmicas (`.so`), uso de GCC e flags de compilação, linking estático/dinâmico, testes unitários simples via programas clientes.
- Competências demonstradas: design de API em C, gestão de builds e dependências locais, entendimento profundo de linking, símbolos e visibilidade, otimização e testes de correção.

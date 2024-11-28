#!/bin/bash

# Obtendo o nome do usuário que executou o script
usuario=$(whoami)

# Obtendo a data atual
dia=$(date +"%d")
mes=$(date +"%m")
ano=$(date +"%Y")

# Criando a saudação
saudacao="Olá $usuario,
Hoje é dia $dia, do mês $mes do ano de $ano."

# Exibindo a saudação na tela
echo -e "$saudacao"

# Anexando a saudação ao arquivo saudacao.log
echo -e "$saudacao" >> saudacao.log

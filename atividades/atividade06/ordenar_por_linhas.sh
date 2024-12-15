#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Uso: $0 <caminho_do_diretorio>"
  exit 1
fi

diretorio=$1

if [ ! -d "$diretorio" ]; then
  echo "Erro: O diretório '$diretorio' não existe."
  exit 1
fi

arquivos=$(find "$diretorio" -maxdepth 1 -type f -name "*.txt")
if [ -z "$arquivos" ]; then
  echo "Erro: O diretório '$diretorio' não contém arquivos de texto."
  exit 1
fi

for arquivo in $arquivos; do
  num_linhas=$(wc -l < "$arquivo")
  echo "$num_linhas $arquivo"
done | sort -n | while read -r linha; do
  qtd_linhas=$(echo "$linha" | cut -d' ' -f1)
  nome_arquivo=$(echo "$linha" | cut -d' ' -f2-)
  echo "$nome_arquivo: $qtd_linhas linhas"
done

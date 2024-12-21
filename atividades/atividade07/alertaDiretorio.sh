#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <intervalo_em_segundos> <caminho_do_diretorio>"
  exit 1
fi

INTERVALO=$1
DIRETORIO=$2
LOG_FILE="dirSensors.log"

if [ ! -d "$DIRETORIO" ]; then
  echo "Erro: O diretório $DIRETORIO não existe."
  exit 1
fi

arquivos_anteriores=($(ls -1 "$DIRETORIO"))
quantidade_anterior=${#arquivos_anteriores[@]}

while true; do
  sleep "$INTERVALO"

  arquivos_atuais=($(ls -1 "$DIRETORIO"))
  quantidade_atual=${#arquivos_atuais[@]}

  if [ "$quantidade_anterior" -ne "$quantidade_atual" ]; then
    data=$(date "+%d-%m-%Y %H:%M:%S")

    adicionados=($(comm -13 <(printf "%s\n" "${arquivos_anteriores[@]}" | sort) <(printf "%s\n" "${arquivos_atuais[@]}" | sort)))
    removidos=($(comm -23 <(printf "%s\n" "${arquivos_anteriores[@]}" | sort) <(printf "%s\n" "${arquivos_atuais[@]}" | sort)))

    mensagem="[$data] Alteração! $quantidade_anterior->$quantidade_atual."
    if [ "${#adicionados[@]}" -gt 0 ]; then
      mensagem+=" Adicionados: ${adicionados[*]}"
    fi
    if [ "${#removidos[@]}" -gt 0 ]; then
      mensagem+=" Removidos: ${removidos[*]}"
    fi

    echo "$mensagem" | tee -a "$LOG_FILE"

    arquivos_anteriores=(${arquivos_atuais[@]})
    quantidade_anterior=$quantidade_atual
  fi

done


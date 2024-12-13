#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <intervalo_em_segundos> <diretorio_para_monitorar>"
  exit 1
fi

INTERVALO=$1
DIRETORIO=$2
LOGFILE="dirSensors.log"

if [ ! -d "$DIRETORIO" ]; then
  echo "Erro: O diretório '$DIRETORIO' não existe."
  exit 1
fi

listar_arquivos() {
  ls "$DIRETORIO"
}

ARQUIVOS_ANTES=$(listar_arquivos)
COUNT_ANTES=$(echo "$ARQUIVOS_ANTES" | wc -l)

while true; do
  sleep $INTERVALO

  ARQUIVOS_AGORA=$(listar_arquivos)
  COUNT_AGORA=$(echo "$ARQUIVOS_AGORA" | wc -l)

  if [ "$COUNT_ANTES" -ne "$COUNT_AGORA" ]; then
    DATA=$(date "+%d-%m-%Y %H:%M:%S")

    ADICIONADOS=$(comm -13 <(echo "$ARQUIVOS_ANTES" | sort) <(echo "$ARQUIVOS_AGORA" | sort))
    REMOVIDOS=$(comm -23 <(echo "$ARQUIVOS_ANTES" | sort) <(echo "$ARQUIVOS_AGORA" | sort))

    MENSAGEM="$DATA Alteração! $COUNT_ANTES->$COUNT_AGORA."
    if [ -n "$REMOVIDOS" ]; then
      MENSAGEM+=" Removidos: $REMOVIDOS."
    fi
    if [ -n "$ADICIONADOS" ]; then
      MENSAGEM+=" Adicionados: $ADICIONADOS."
    fi

    echo "$MENSAGEM" >> "$LOGFILE"

    # Atualiza os valores para a próxima iteração
    ARQUIVOS_ANTES="$ARQUIVOS_AGORA"
    COUNT_ANTES="$COUNT_AGORA"
  fi

done

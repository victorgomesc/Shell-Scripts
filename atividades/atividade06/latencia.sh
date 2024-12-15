#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Uso: $0 <arquivo_com_ips>"
  exit 1
fi

ARQUIVO=$1

if [ ! -f "$ARQUIVO" ]; then
  echo "Arquivo não encontrado: $ARQUIVO"
  exit 1
fi

calcular_latencia() {
  local ip=$1
  local media=$(ping -c 3 $ip | grep 'rtt' | cut -d '/' -f 5)
  if [ -z "$media" ]; then
    echo "$ip ERROR"
  else
    echo "$ip $media ms"
  fi
}

while IFS= read -r ip; do
  calcular_latencia "$ip"
done < "$ARQUIVO" | sort -k2 -n

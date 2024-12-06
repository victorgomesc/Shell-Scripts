#!/bin/bash

# Função para verificar se um parâmetro é numérico
eh_numero() {
  [[ $1 =~ ^-?[0-9]+([.][0-9]+)?$ ]]
}

# Verifica se foram passados exatamente 3 parâmetros
if [ $# -ne 3 ]; then
  echo "Uso: $0 num1 num2 num3"
  exit 1
fi

# Verifica se todos os parâmetros são números
for param in "$@"; do
  if ! eh_numero "$param"; then
    echo "Opa!!! $param não é número."
    exit 1
  fi
done

# Determina o maior número
maior=$1
if (( $(echo "$2 > $maior" | bc -l) )); then
  maior=$2
fi
if (( $(echo "$3 > $maior" | bc -l) )); then
  maior=$3
fi

# Retorna o maior número
echo "$maior"

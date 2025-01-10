#!/bin/bash

read -p "Informe o arquivo: " arquivo

if [[ ! -f "$arquivo" ]]; then
    echo "Erro: O arquivo '$arquivo' não existe."
    exit 1
fi

cat "$arquivo" | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | tr ' ' '\n' | \
grep -v '^$' | sort | uniq -c | sort -nr | while read -r count word; do
    echo "$word:$count"
done

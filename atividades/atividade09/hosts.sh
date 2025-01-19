#!/bin/bash

DB_FILE="hosts.db"

adicionar() {
    local hostname="$1"
    local ip="$2"

    if grep -q "^$hostname " "$DB_FILE"; then
        echo "Erro: O hostname '$hostname' já existe."
        exit 1
    fi

    echo "$hostname $ip" >> "$DB_FILE"
    echo "Adicionado: $hostname $ip"
}

remover() {
    local hostname="$1"

    if ! grep -q "^$hostname " "$DB_FILE"; then
        echo "Erro: O hostname '$hostname' não foi encontrado."
        exit 1
    fi

    grep -v "^$hostname " "$DB_FILE" > "$DB_FILE.tmp" && mv "$DB_FILE.tmp" "$DB_FILE"
    echo "Removido: $hostname"
}

procurar() {
    local termo="$1"
    local reversa="$2"

    if [[ "$reversa" == "true" ]]; then
        grep " $termo$" "$DB_FILE"
    else
        grep "^$termo " "$DB_FILE"
    fi
}

listar() {
    if [[ ! -s "$DB_FILE" ]]; then
        echo "O arquivo de hosts está vazio."
    else
        cat "$DB_FILE"
    fi
}

if [[ ! -f "$DB_FILE" ]]; then
    touch "$DB_FILE"
fi

while getopts ":a:i:d:rl" opt; do
    case "$opt" in
        a) 
            hostname="$OPTARG"
            ;;
        i)  
            ip="$OPTARG"
            adicionar "$hostname" "$ip"
            ;;
        d)  
            remover "$OPTARG"
            ;;
        r)  
            reversa=true
            ;;
        l)  
            listar
            ;;
        \?) 
            echo "Opção inválida: -$OPTARG"
            exit 1
            ;;
    esac

done

shift $((OPTIND - 1))
if [[ $# -gt 0 ]]; then
    procurar "$1" "$reversa"
fi


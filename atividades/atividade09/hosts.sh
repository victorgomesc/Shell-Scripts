#!/bin/bash

# Arquivo de armazenamento
DB_FILE="hosts.db"

# Função para adicionar um par hostname-IP
adicionar() {
    local hostname="$1"
    local ip="$2"

    # Verifica se a entrada já existe
    if grep -q "^$hostname " "$DB_FILE"; then
        echo "Erro: O hostname '$hostname' já existe."
        exit 1
    fi

    echo "$hostname $ip" >> "$DB_FILE"
    echo "Adicionado: $hostname $ip"
}

# Função para remover uma entrada pelo hostname
remover() {
    local hostname="$1"

    if ! grep -q "^$hostname " "$DB_FILE"; then
        echo "Erro: O hostname '$hostname' não foi encontrado."
        exit 1
    fi

    grep -v "^$hostname " "$DB_FILE" > "$DB_FILE.tmp" && mv "$DB_FILE.tmp" "$DB_FILE"
    echo "Removido: $hostname"
}

# Função para procurar entradas (normal ou reversa)
procurar() {
    local termo="$1"
    local reversa="$2"

    if [[ "$reversa" == "true" ]]; then
        grep " $termo$" "$DB_FILE"
    else
        grep "^$termo " "$DB_FILE"
    fi
}

# Função para listar todas as entradas
listar() {
    if [[ ! -s "$DB_FILE" ]]; then
        echo "O arquivo de hosts está vazio."
    else
        cat "$DB_FILE"
    fi
}

# Inicializa o arquivo, se não existir
if [[ ! -f "$DB_FILE" ]]; then
    touch "$DB_FILE"
fi

# Tratamento de parâmetros com getopts
while getopts ":a:i:d:rl" opt; do
    case "$opt" in
        a)  # Adicionar hostname
            hostname="$OPTARG"
            ;;
        i)  # IP para o hostname
            ip="$OPTARG"
            adicionar "$hostname" "$ip"
            ;;
        d)  # Remover hostname
            remover "$OPTARG"
            ;;
        r)  # Buscar reversa por IP
            reversa=true
            ;;
        l)  # Listar todas as entradas
            listar
            ;;
        \?) # Opção inválida
            echo "Opção inválida: -$OPTARG"
            exit 1
            ;;
    esac

done

# Caso especial: buscar hostname sem outros parâmetros
shift $((OPTIND - 1))
if [[ $# -gt 0 ]]; then
    procurar "$1" "$reversa"
fi


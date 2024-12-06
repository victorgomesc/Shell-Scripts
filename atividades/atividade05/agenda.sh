#!/bin/bash

AGENDA_FILE="agenda.db"

# Função para criar o arquivo se ele não existir
criar_arquivo_se_nao_existir() {
  if [ ! -f "$AGENDA_FILE" ]; then
    touch "$AGENDA_FILE"
    echo "Arquivo criado!!!"
  fi
}

# Função para listar os contatos
listar_contatos() {
  if [ ! -s "$AGENDA_FILE" ]; then
    echo "Arquivo vazio!!!"
  else
    cat "$AGENDA_FILE"
  fi
}

# Função para adicionar um contato
adicionar_contato() {
  local nome="$1"
  local email="$2"

  if grep -q ":$email$" "$AGENDA_FILE"; then
    echo "O e-mail $email já está cadastrado."
  else
    echo "$nome:$email" >> "$AGENDA_FILE"
    echo "Usuário $nome adicionado."
  fi
}

# Função para remover um contato
remover_contato() {
  local email="$1"

  if grep -q ":$email$" "$AGENDA_FILE"; then
    local nome=$(grep ":$email$" "$AGENDA_FILE" | cut -d':' -f1)
    sed -i "/:$email$/d" "$AGENDA_FILE"
    echo "Usuário $nome removido."
  else
    echo "O e-mail $email não foi encontrado."
  fi
}

# Verifica a operação solicitada
case "$1" in
  listar)
    criar_arquivo_se_nao_existir
    listar_contatos
    ;;
  adicionar)
    if [ $# -ne 3 ]; then
      echo "Uso: $0 adicionar 'Nome' 'email'"
      exit 1
    fi
    criar_arquivo_se_nao_existir
    adicionar_contato "$2" "$3"
    ;;
  remover)
    if [ $# -ne 2 ]; then
      echo "Uso: $0 remover 'email'"
      exit 1
    fi
    criar_arquivo_se_nao_existir
    remover_contato "$2"
    ;;
  *)
    echo "Uso: $0 {listar|adicionar|remover}"
    exit 1
    ;;
esac

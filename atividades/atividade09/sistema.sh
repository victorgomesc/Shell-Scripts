#!/bin/bash

# Função para exibir o menu
menu() {
    clear
    echo "===== Monitor de Sistema ====="
    echo "1. Tempo ligado (uptime)"
    echo "2. Últimas Mensagens do Kernel (dmesg | tail -n 10)"
    echo "3. Memória Virtual (vmstat 1 10)"
    echo "4. Uso da CPU por núcleo (mpstat -P ALL 1 5)"
    echo "5. Uso da CPU por processos (pidstat 1 5)"
    echo "6. Uso da Memória Física (free -m)"
    echo "7. Sair"
    echo "================================"
    echo -n "Escolha uma opção: "
}

# Loop principal
while true; do
    menu
    read opcao
    case $opcao in
        1)
            clear
            echo "Tempo ligado:"
            uptime
            ;;
        2)
            clear
            echo "Últimas mensagens do Kernel:"
            dmesg | tail -n 10
            ;;
        3)
            clear
            echo "Memória Virtual:"
            vmstat 1 10
            ;;
        4)
            clear
            echo "Uso da CPU por núcleo:"
            mpstat -P ALL 1 5
            ;;
        5)
            clear
            echo "Uso da CPU por processos:"
            pidstat 1 5
            ;;
        6)
            clear
            echo "Uso da Memória Física:"
            free -m
            ;;
        7)
            echo "Saindo..."
            exit 0
            ;;
        *)
            clear
            echo "Opção inválida. Tente novamente."
            ;;
    esac
    echo
    read -p "Pressione Enter para voltar ao menu..."
done

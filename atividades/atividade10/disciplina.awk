BEGIN {
    FS=":"; 
    print "Aluno:Situação:Média";
}

NR > 1 {
    media = ($2 + $3 + $4) / 3;  
    
    if (media >= 7) {
        situacao = "Aprovado";
    } else if (media >= 5) {
        situacao = "Final";
    } else {
        situacao = "Reprovado";
    }
    
    soma[1] += $2;
    soma[2] += $3;
    soma[3] += $4;
    
    contagem++;
    
    printf "%s:%s:%.1f\n", $1, situacao, media;
}

END {
    printf "Média das Provas: %.1f %.1f %.1f\n", soma[1] / contagem, soma[2] / contagem, soma[3] / contagem;
}

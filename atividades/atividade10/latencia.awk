BEGIN {
    print "Executando teste de latência...\n";
}

{
    cmd = "ping -c 3 -q " $1 " | awk -F'/' 'END {print $5}'";
    cmd | getline latencia;
    close(cmd);
    
    if (latencia == "") {
        latencia = "N/A";
    } else {
        latencia = latencia "ms";
    }
    
    print $1, latencia;
}

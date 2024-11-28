# 1. Encontre todas as linhas com mensagens que não são do sshd.
grep -v 'sshd' auth.log

# 2. Encontre todas as linhas com mensagens que indicam um login de sucesso via sshd cujo nome do usuário começa com a letra j.
grep 'sshd.*Accepted.*for j' auth.log

# 3. Encontre todas as vezes que alguém tentou fazer login via root através do sshd.
grep "sshd.*root" auth.log


# 4. Encontre todas as vezes que alguém conseguiu fazer login com sucesso nos dias 11 ou 12 de Outubro.
grep -E "Oct (11|12).*Connection reset" auth.log


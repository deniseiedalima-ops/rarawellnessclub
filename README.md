# RARA Management Hub

## Configuração do login e banco compartilhado

1. No Supabase, abra **SQL Editor → New query**.
2. Cole e execute o conteúdo de `supabase-shared-workspace.sql`.
3. No site RARA, informe a **Project URL** e a chave pública **publishable/anon**. Não use `service_role` ou secret key.
4. Entre com Google usando `rarawellnessclub@gmail.com`.
5. O primeiro login que encontrar a tabela vazia migrará os dados locais desse navegador para `rara_workspace`. Os logins seguintes carregarão o conteúdo compartilhado.
6. Alterações gravadas serão enviadas ao Supabase e atualizações remotas serão exibidas em tempo real.

## Segurança
A política RLS limita leitura e escrita ao e-mail `rarawellnessclub@gmail.com`. Não publique a chave `service_role`. O site precisa ser publicado com HTTPS.

## Importante sobre migração
Antes do primeiro login com sincronização, mantenha no navegador que contém os dados mais completos a versão atual do RARA. O primeiro login inicializa a linha compartilhada a partir dos dados locais se ela ainda não existir. Depois que a linha existir, ela passa a ser a fonte principal para todos os dispositivos.

# Implantação de CMS com Ansible

Este script Ansible automatiza a implantação de uma aplicação Strapi CMS em Docker.

## Passos

1. Instala Docker e Docker Compose.
2. Adiciona o usuário 'ubuntu' ao grupo Docker.
3. Verifica se o Docker está funcionando corretamente.
4. Atualiza a lista de pacotes do sistema.
5. Obtém o endereço IP do manager.
6. Inicializa o Docker Swarm com o endereço IP do manager.
7. Insere a entrada do DuckDNS ao final do arquivo /etc/hosts.
8. Copia a pasta local para o servidor remoto.
9. Altera as permissões da pasta 'letsencrypt' para "0600".
10. Na máquina local, constrói a imagem Docker do Strapi usando Docker Compose.
11. Salva a imagem Docker em um arquivo tar.
12. Copia o arquivo tar da imagem Docker do Strapi para o servidor remoto.
13. Carrega a imagem Docker do Strapi a partir do arquivo tar no servidor remoto.
14. Cria a rede 'web' do tipo overlay.
15. Lê as variáveis de ambiente do arquivo .env e exporta para o ambiente.
16. Executa a stack do Swarm usando o arquivo docker-compose.yml.
17. Apaga o arquivo tar da imagem Docker remota do Strapi após o deploy.

## Observações

O build da imagem Docker do Strapi é realizado localmente para agilizar o processo de implantação, pois a instância EC2 t2.micro possui recursos limitados. O processo de construção da imagem Docker no servidor pode ser lento e resultar em erros ou travamentos. Outra alternativa é utilizar um repositório de imagens Docker, como o Docker Hub.

Instruções:

1. Configure o nome do domínio duckdns no arquivo vars.yml.

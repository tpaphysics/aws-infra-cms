## Integração do Plugin AWS S3 para Strapi

Este é um plugin para o Strapi que permite a integração com o serviço de armazenamento S3 da AWS e o serviço de distribuição de conteúdo CloudFront. A integração já está configurada e requer apenas a configuração do arquivo .env. Além disso, um middleware foi configurado na pasta `/config/middleware.ts` para exibir as miniaturas das imagens.

# IP interno da ec2

cat /etc/hostname | sed -r 's/ip-//; s/-/./g'

## Docker Swarm Init

# Acrescentar Host ao /etc/hosts

echo "em-cms.duckdns.org" >>/etc/hosts

# Cria a rede web overlay

dockr network create -d overlay web

# Lê as variaveis de ambiente do arquivo .env pq o docker swarm nao lê por default

export $(grep -v '^#' .env | sed 's/#.\*//' | xargs)

# Sobe o cluster swarm

docker stack deploy -c docker-compose.yml cms

#!/bin/bash

# Criação da infraestrutura na AWS usando Terraform
cd ./terraform
terraform init
terraform apply -auto-approve



#Obtem o endereço DNS da instância EC2
ec2_address=$(awk -F'"' '/public_dns/ {gsub(/,/, "", $4); print $4}' terraform.tfstate)

# Obtém o endereço DNS da instância RDS
rds_address=$(grep '"address"' terraform.tfstate | awk -F'"' '{print $4}')

# Obtem o DNS da instância CloudFront
cloudfront_address=$(grep '"domain_name"' terraform.tfstate | awk -F'"' '{print $4}' | grep "cloudfront.net")

# Obtem o DNS da bucket S3
s3_address=$(grep '"bucket"' terraform.tfstate | awk -F'"' '{print $4}' | awk 'NR==2')

cd ..
#
## Substitui o valor das variáveis de ambiente do Strapi no arquivo .env
cd ./app/aws-strapi
sed -i "s|^DATABASE_HOST=.*|DATABASE_HOST=$rds_address|" .env
sed -i "s|^CDN_URL=.*|CDN_URL=https://$cloudfront_address|" .env
sed -i "s|^AWS_BUCKET=.*|AWS_BUCKET=$s3_address|" .env
sed -i "s|^CDN_MIDDLEWARE=.*|CDN_MIDDLEWARE=$cloudfront_address|" .env

## Configura o middleware do Strapi para usar o CloudFront e exibir as miniaturas das imagens do S3
##sed -i "s|\"[^\"]*\.cloudfront\.net\"|\"$cloudfront_address\"|g" middlewares.ts
#
cd ../../
#
## Aguarda 10 segundos para garantir a disponibilidade dos recursos
sleep 10
#
## Inicia o script Ansible para configurar a instância EC2
cd ./ansible
ansible-playbook -i aws_ec2.yml swap.yml
ansible-playbook -i aws_ec2.yml app.yml

# Obtém o endereço DNS da instância EC2 com duckdns
cd ../app
duckdns_address=$(grep -oP '^DOMAIN=\K.*' .env)


# Exibe os endereços DNS dos recursos criados
output=$(echo -e "DNS duckdns EC2: https://$duckdns_address\nDNS AWS EC2: $ec2_address\nDNS RDS: $rds_address\nDNS CloudFront: $cloudfront_address\nDNS do bucket S3: $s3_address")
echo "$output" > ../output.txt
echo "$output"
exit 0

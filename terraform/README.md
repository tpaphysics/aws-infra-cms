# Configuração de Infraestrutura com Terraform

Este código Terraform automatiza a criação de recursos na AWS para gerenciar uma instância EC2, um grupo de segurança e uma instância de banco de dados RDS.

## Passos

1. Configure o provedor AWS no arquivo de configuração do Terraform.
2. Crie um par de chaves SSH para acesso à instância EC2.
3. Crie um grupo de segurança e defina as regras de entrada e saída somente entre instancias.
4. Crie a instância EC2 com base na AMI Ubuntu, usando a chave SSH e o grupo de segurança.
5. Crie um grupo de segurança para o RDS e defina as regras de acesso.
6. Crie a instância de banco de dados RDS com base nas configurações fornecidas.
7. Cria um bucket S3 privado para armazenamento de imagens da aplicação.
8. Criar um CloudFront como CDN para o bucket S3.

## Notas

1. Somente as instancias EC2 e e os dispositivos na sua rede local podem acessar o RDS.
2. E as instancias EC2 do mesmo grupo de segurança podem se comunicar entre si.
3. Configure o ip externo de sua rede local no variables.tf para acesso SSH à instância EC2 e o RDS.

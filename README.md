# Criação de infraestrutura e deploy de aplicação Strapi na AWS

<p align="center">
  <a href="https://aws.amazon.com/ec2/"><img src="https://img.shields.io/badge/AWS-EC2-orange?logo=amazon-aws&logoColor=white&style=flat" alt="AWS EC2"></a>
  <a href="https://aws.amazon.com/s3/"><img src="https://img.shields.io/badge/AWS-S3-blue?logo=amazon-aws&logoColor=white&style=flat" alt="AWS S3"></a>
  <a href="https://aws.amazon.com/rds/"><img src="https://img.shields.io/badge/AWS-RDS-red?logo=amazon-aws&logoColor=white&style=flat" alt="AWS RDS"></a>
  <a href="https://aws.amazon.com/cloudfront/"><img src="https://img.shields.io/badge/AWS-CloudFront-yellow?logo=amazon-aws&logoColor=white&style=flat" alt="AWS CloudFront"></a>
</p>

<p align="center">
  <a href="https://www.terraform.io/"><img src="https://img.shields.io/badge/Terraform-0.15+-blueviolet?logo=terraform&logoColor=white&style=flat" alt="Terraform"></a>
  <a href="https://www.ansible.com/"><img src="https://img.shields.io/badge/Ansible-2.10+-blue?logo=ansible&logoColor=white&style=flat" alt="Ansible"></a>
  <a href="https://docs.docker.com/swarm/"><img src="https://img.shields.io/badge/Docker_Swarm-latest-blue?logo=docker&logoColor=white&style=flat" alt="Docker Swarm"></a>
</p>

## Introdução

Esta pipeline constrói toda infraestrutura e realiza o deploy de uma aplicação **Strapi** na AWS utilizando **Terraform**, **Ansible** e **Docker Swarm**. A infraestrutura AWS inclui instâncias **EC2**, **RDS**, **S3** e **CloudFront**. Além disso, utilizamos **Traefik** como load balancer, proxy reverso com certificado SSL gratuito emitido pelo Let's Encrypt e dimínio dinâmico criado pelo DuckDNS, gratuito.

## Pré-requisitos

1. Renomeie **.env.example** para **.env**, **env.example.tf** para **variables.tf** e o vars.example.yml para **vars.yml**.
2. Configure um usuário IAM com acesso programático com as seguintes permisões:
   ```json
   "Action": [
   "s3:PutObject",
   "s3:GetObject",
   "s3:ListBucket",
   "s3:DeleteObject",
   "s3:PutObjectAcl"
   ],
   ```
3. Obtenha as chave de acesso e secret key do usuário IAM.
4. Instale e configure o AWS CLI.
5. Instale o Terraform e Ansible.
6. Obtenha o token e subdomínio no [duckdns](https://www.duckdns.org/).

## Configuração

Configure as credenciais do AWS CLI:

```bash
aws configure
```

Para acesso SSH à instância EC2, indique a chave pública em **/terraform/variables.tf**:

```ruby
resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
```

## Start:

```bash
./start.sh
```

## Destroy:

```bash
./destroy.sh
```

## Notas:

O objetivo foi criar uma infraestrutura simples e de baixo custo, utilizando serviços gratuitos da AWS. DNS dinâmico criado pelo DuckDNS, juntamente com um certificado SSL gerado pelo Let's Encrypt de forma gratuíta. A aplicação possui 2 réplicas do Strapi, 1 réplica do Traefik e 1 réplica do duckdns. Utiliza 1 instância EC2 t2.micro, 1 instância RDS db.t3.micro, 1 bucket S3, 1 distribuição CloudFront.
O bucket S3 é privado e assível apenas pelo CloudFront que atua como CDN diminuindo os custos de transferência de dados do bucket S3 para a internet.

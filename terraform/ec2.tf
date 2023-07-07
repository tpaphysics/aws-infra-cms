resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform-key"
  public_key = file(var.pub_key_path)
}

resource "aws_security_group" "terraform-sg" {
# Permite cominicação entre instâncias do mesmo security group    
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ip_externo]
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_manager" {
  ami           = var.ubuntu_ami
  instance_type = var.aws_ec2_instance
  key_name = "terraform-key"
  count = 1

  root_block_device {
    volume_size = 20  
  }

  tags = {
    Name = "cms"
    type = "cms"
  }
  security_groups = [aws_security_group.terraform-sg.name]
}
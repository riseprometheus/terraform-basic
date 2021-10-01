terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fa1a201fb8c369dd"
  instance_type = "t2.micro"
  key_name = "minecraft"
  vpc_security_group_ids = [aws_security_group.ssh-permissions.id]
  subnet_id = aws_subnet.server_public_subnet.id
  tags = {
    Name = var.instance_name
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "minecraft"
  public_key = tls_private_key.ssh.public_key_openssh

}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "minecraft.pem"
  file_permission = "0600"
}

output "ip_address" {
  value = aws_instance.app_server.public_ip
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "deploy" {
  key_name   = "github-deploy"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "web_sg" {
  name = "mi-web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ip]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deploy.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "mi-web"
  }
}

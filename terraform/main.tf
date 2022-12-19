provider "aws" {
  region = var.region
}

locals {
  default_tags = {
    Name        = var.server_name
    environment = var.environment
    owner       = var.owner
  }
}

data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "allows ssh traffic"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.default_tags
}

resource "aws_instance" "work_smarter_instance" {
  ami           = data.aws_ami.amzn2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<EOF
    #!/bin/bash
    sudo yum update && sudo yum upgrade
    sudo wget -O screenfetch https://git.io/vaHfR
    sudo chmod +x screenfetch
    sudo mv screenfetch /usr/local/bin
    echo 'Hello world!' > /tmp/hello.txt
  EOF

  tags = local.default_tags
}
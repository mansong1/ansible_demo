provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "tls_private_key" "ssh" {
  count = (var.key_name == null && var.ssh_public_key == null && var.generate_ssh_key) ? 1 : 0

  algorithm = "ED25519"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "${var.name}-ssh"
  description = "SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ssh"
  }
}

resource "aws_key_pair" "this" {
  count = (var.key_name == null && (var.ssh_public_key != null || var.generate_ssh_key)) ? 1 : 0

  key_name   = "${var.name}-key"
  public_key = var.ssh_public_key != null ? var.ssh_public_key : tls_private_key.ssh[0].public_key_openssh
}

locals {
  effective_key_name = var.key_name != null ? var.key_name : aws_key_pair.this[0].key_name
}

resource "aws_instance" "linux" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  associate_public_ip_address = true
  key_name                    = local.effective_key_name

  lifecycle {
    precondition {
      condition     = local.effective_key_name != null
      error_message = "No SSH key configured. Set key_name, or set ssh_public_key, or enable generate_ssh_key."
    }
  }

  tags = {
    Name = var.name
  }
}

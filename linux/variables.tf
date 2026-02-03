variable "region" {
  type    = string
  default = "us-east-1"
}

variable "name" {
  type    = string
  default = "ansible-demo-linux"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "allowed_ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "key_name" {
  type    = string
  default = null
}

variable "generate_ssh_key" {
  type    = bool
  default = true
}

variable "ssh_public_key" {
  type    = string
  default = null
}

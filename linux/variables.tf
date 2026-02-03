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

variable "ssh_public_key" {
  type    = string
  default = null

  validation {
    condition     = var.key_name != null || var.ssh_public_key != null
    error_message = "Set either key_name (existing EC2 key pair) or ssh_public_key (to create a key pair)."
  }
}

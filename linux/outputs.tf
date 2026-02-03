output "public_ip" {
  value = aws_instance.linux.public_ip
}

output "public_dns" {
  value = aws_instance.linux.public_dns
}

output "ssh_command" {
  value = "ssh ec2-user@${aws_instance.linux.public_dns}"
}

output "ansible_inventory_host" {
  value = "${aws_instance.linux.public_dns} ansible_user=ec2-user"
}

output "key_name" {
  value = local.effective_key_name
}

output "ssh_private_key_pem" {
  value     = length(tls_private_key.ssh) > 0 ? tls_private_key.ssh[0].private_key_openssh : null
  sensitive = true
}

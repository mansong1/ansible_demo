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

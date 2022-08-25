output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}

output "bastion_security_group_id" {
    value = aws_security_group.bastion_sg.id
}

output "private_instance_security_group_id" {
    value = aws_security_group.private_instance_sg.id
}
# Public subnet
output "public_subnet_id" {
    value   = aws_subnet.public_subnet.id
}

# Private subnet
output "private_subnet_id" {
    value   = aws_subnet.private_subnet.id
}

# Bastion
output "bastion_security_group_id" {
    value   = aws_security_group.bastion_sg.id
}

# Private instance
output "private_instance_security_group_id" {
    value   = aws_security_group.private_instance_sg.id
}
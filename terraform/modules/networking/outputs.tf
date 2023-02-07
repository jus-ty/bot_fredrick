# Private subnet
output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}

# Security group
output "create_poll_lambda_security_group_id" {
    value = aws_security_group.create_poll_lambda_security_group.id
}

# NAT Instance
output "nat_instance_arn" {
    value = aws_instance.nat_instance.arn
}

output "nat_instance_id" {
    value = aws_instance.nat_instance.id
}
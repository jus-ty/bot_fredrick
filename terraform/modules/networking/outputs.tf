# Security group
output "lambda_security_group_id" {
    value   = aws_security_group.lambda_security_group.id
}

output "private_subnet_id" {
    value   = aws_subnet.private_subnet.id
}
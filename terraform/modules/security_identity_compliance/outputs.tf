# IAM Role
output "iam_role_lambda_arn" {
    value  = aws_security_group.lambda_iam_role.arn
}
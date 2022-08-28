# IAM Role
output "iam_role_lambda_arn" {
    value = aws_iam_role.lambda_iam_role.arn
}
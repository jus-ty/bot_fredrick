# IAM Role
output "iam_role_create_poll_lambda_arn" {
    value = aws_iam_role.create_poll_lambda_iam_role.arn
}
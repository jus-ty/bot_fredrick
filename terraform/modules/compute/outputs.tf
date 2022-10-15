# Lambda ARN - create_poll
output "create_poll_lambda_function_unique_arn" {
  description = "The ARN of the create_poll Lambda Function"
  value       = aws_lambda_function.create_poll_lambda.arn
}


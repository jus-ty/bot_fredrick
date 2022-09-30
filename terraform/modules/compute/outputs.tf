# Lambda ARN
output "lambda_function_unique_arn" {
  description = "The ARN of the Lambda Function"
  value       = aws_lambda_function.lambda.arn
}


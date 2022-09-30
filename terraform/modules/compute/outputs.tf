# Lambda ARN
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = try(aws_lambda_function.lambda[0].arn, "")
}


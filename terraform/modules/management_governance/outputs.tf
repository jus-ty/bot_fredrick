# SSM Parameter - email
output "ssm_parameter_service_account_email_unique_arn" {
  description = "The ARN of the service account email SSM parameter"
  value       = aws_ssm_parameter.service_account_email.arn
}

# SSM Parameter - password
output "ssm_parameter_service_account_password_unique_arn" {
  description = "The ARN of the service account password SSM parameter"
  value       = aws_ssm_parameter.service_account_password.arn
}

# SSM Parameter - thread_id
output "ssm_parameter_thread_id_unique_arn" {
  description = "The ARN of the thread id SSM parameter"
  value       = aws_ssm_parameter.thread_id.arn
}

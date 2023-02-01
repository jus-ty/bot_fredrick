# SSM Parameter - email
resource "aws_ssm_parameter" "service_account_email" {
  name    = "${var.ssm_parameter_account_email_name}"
  type    = "String"
  value   = "${var.ssm_parameter_account_email_value}"
  tags    = var.ssm_parameter_account_email_tags
}

# SSM Parameter - password
resource "aws_ssm_parameter" "service_account_password" {
  name    = "${var.ssm_parameter_account_password_name}"
  type    = "String"
  value   = "${var.ssm_parameter_account_password_value}"
  tags    = var.ssm_parameter_account_password_tags
}

# SSM Parameter - thread_id
resource "aws_ssm_parameter" "thread_id" {
  name    = "${var.ssm_parameter_thread_id_name}"
  type    = "String"
  value   = "${var.ssm_parameter_thread_id_value}"
  tags    = var.ssm_parameter_thread_id_tags
}
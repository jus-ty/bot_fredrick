resource "aws_lambda_function" "lambda" {
  function_name         = var.lambda_name
  role                  = modules.security_identity_compliance.iam_role_lambda_arn
  runtime               = "python3.8"
  handler               = "lambda_function.lambda_handler"

  vpc_config {
    #subnet_ids          = []
    security_group_ids  = [module.networking.lambda_security_group_id]
  }
}
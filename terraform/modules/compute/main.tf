resource "aws_lambda_function" "create_poll_lambda" {
  function_name         = var.create_poll_lambda_name
  role                  = var.create_poll_lambda_iam_role
  runtime               = "python3.8"
  handler               = "main.lambda_handler" # python_script_name.driver_function_name
  timeout               = 180
  memory_size           = 1048
  filename              = "${data.archive_file.create_poll_lambda_zip_file.output_path}"
  source_code_hash      = "${data.archive_file.create_poll_lambda_zip_file.output_base64sha256}"
  tags                  = var.create_poll_lambda_tags
  layers                = [
                          "arn:aws:lambda:ap-southeast-2:537519792485:layer:HeadlessChromium:2"
                          ]
  
  environment {
    variables = {
      env = var.lambda_environment_variable_env
    }
  }

  vpc_config {
    subnet_ids          = [var.lambda_private_subnet_id]
    security_group_ids  = [var.create_poll_lambda_security_group]
  }

}

resource "aws_lambda_permission" "allow_cloudwatch_create_poll_lambda" {
  statement_id          = "AllowExecutionFromCloudWatch"
  action                = "lambda:InvokeFunction"
  function_name         = var.create_poll_lambda_name
  principal             = "events.amazonaws.com"
  source_arn            = var.create_poll_eventbridge_arn        # ARN of the specific resource within that service to grant permission to.
} 

data "archive_file" "create_poll_lambda_zip_file" {
  type                  = "zip"
  output_path           = "/tmp/create_poll_lambda.zip"
  source {
    content             = file("${path.module}/src/create_poll/main.py")
    filename            = "main.py"
  }
}
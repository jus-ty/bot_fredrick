resource "aws_lambda_function" "lambda" {
  function_name         = var.lambda_name
  role                  = var.lambda_iam_role
  runtime               = "python3.8"
  handler               = "main.lambda_handler" # python_script_name.driver_function_name
  timeout               = 180
  memory_size           = 1048
  filename              = "${data.archive_file.lambda_zip_file.output_path}"
  source_code_hash      = "${data.archive_file.lambda_zip_file.output_base64sha256}"
  tags                  = var.lambda_name_tags
  layers                = [
                          "arn:aws:lambda:ap-southeast-2:537519792485:layer:HeadlessChromium:2"
                          ]
  
  environment {
    variables = {
      env = var.lambda_environment_variable_env
    }
  }

  vpc_config {
    subnet_ids          = [var.lambda_subnet_id]
    security_group_ids  = [var.lambda_security_group]
  }

}

resource "aws_lambda_permission" "allow_cloudwatch_create_poll_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal = "events.amazonaws.com"
  source_arn = "arn:aws:lambda:ap-southeast-2:537519792485:function:bot_fredrick_lambda_dev"
} 

data "archive_file" "lambda_zip_file" {
  type                  = "zip"
  output_path           = "/tmp/create_poll_lambda.zip"
  source {
    content             = file("${path.module}/src/create_poll/main.py")
    filename            = "main.py"
  }
}
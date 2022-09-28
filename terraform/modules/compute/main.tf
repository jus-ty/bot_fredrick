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

  vpc_config {
    subnet_ids          = [var.lambda_subnet_id]
    security_group_ids  = [var.lambda_security_group]
  }

}

data "archive_file" "lambda_zip_file" {
  type                  = "zip"
  output_path           = "/tmp/create_poll_lambda.zip"
  source {
    content             = file("${path.module}/src/create_poll/main.py")
    filename            = "main.py"
  }
}
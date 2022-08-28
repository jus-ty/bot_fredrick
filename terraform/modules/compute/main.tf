resource "aws_lambda_function" "lambda" {
  function_name         = var.lambda_name
  role                  = var.lambda_iam_role
  runtime               = "python3.8"
  handler               = "lambda_function.lambda_handler"
  filename              = "${data.archive_file.lambda_zip_file.output_path}"
  source_code_hash      = "${data.archive_file.lambda_zip_file.output_base64sha256}"
  tags                  = var.lambda_name_tags

  vpc_config {
    subnet_ids          = [var.lambda_subnet_id]
    security_group_ids  = [var.lambda_security_group]
  }

}

data "archive_file" "lambda_zip_file" {
  type        = "zip"
  output_path = "/tmp/test.zip"
  source {
    content  = file("${path.module}/test.py")
    filename = "test.py"
  }
}
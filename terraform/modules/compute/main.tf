resource "aws_lambda_function" "create_poll_lambda" {
  function_name               = var.create_poll_lambda_name
  role                        = var.create_poll_lambda_iam_role
  runtime                     = "python3.8"
  handler                     = "main.lambda_handler" # python_script_name.driver_function_name
  timeout                     = 180
  memory_size                 = 1048
  filename                    = "${data.archive_file.create_poll_lambda_zip_file.output_path}"
  source_code_hash            = "${data.archive_file.create_poll_lambda_zip_file.output_base64sha256}"
  tags                        = var.create_poll_lambda_tags
    layers                    = [
                                "${aws_lambda_layer_version.headlesschromium_lambda_layer.arn}"
                                ]
  
  environment {
    variables = {
      env = var.lambda_environment_variable_env
    }
  }

  vpc_config {
    subnet_ids                = [var.lambda_private_subnet_id]
    security_group_ids        = [var.create_poll_lambda_security_group]
  }

}

resource "aws_lambda_permission" "allow_cloudwatch_create_poll_lambda" {
  statement_id                = "AllowExecutionFromCloudWatch"
  action                      = "lambda:InvokeFunction"
  function_name               = aws_lambda_function.create_poll_lambda.function_name
  principal                   = "events.amazonaws.com"
  source_arn                  = var.create_poll_eventbridge_arn        # ARN of the specific resource within that service to grant permission to.
} 

data "archive_file" "create_poll_lambda_zip_file" {
  type                        = "zip"
  output_path                 = "/tmp/create_poll_lambda.zip"
  source {
    content                   = file("${path.module}/src/create_poll/main.py")
    filename                  = "main.py"
  }
}

resource "aws_lambda_layer_version" "headlesschromium_lambda_layer" {
  s3_bucket                   = var.upload_bucket_lambda_layer
  s3_key                      = aws_s3_bucket_object.s3_object_headlesschromium_layer.id
  layer_name                  = "${var.headless_chromium_name}"
  compatible_runtimes         = ["python3.8"]
  compatible_architectures    = ["x86_64"]
}

resource "aws_s3_bucket_object" "s3_object_headlesschromium_layer" {
    bucket                    = var.upload_bucket_lambda_layer
    key                       = "bot_fredrick/${var.headless_chromium_name}"
    source                    = "${path.module}/src/layers/layer-headless_chrome-${var.headless_chromium_version}.zip"
}


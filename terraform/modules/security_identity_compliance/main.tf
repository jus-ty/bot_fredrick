resource "aws_iam_role" "lambda_iam_role" {
  name                = "${var.lambda_iam_role_name}"
  assume_role_policy  = "${data.aws_iam_policy_document.lambda_trust_policy.json}"
  tags                = var.lambda_iam_role_tags
}

data "aws_iam_policy_document" "lambda_trust_policy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole_to_lambda" {
  role       = "${aws_iam_role.lambda_iam_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# https://stackoverflow.com/questions/41177965/aws-lambdathe-provided-execution-role-does-not-have-permissions-to-call-describ
resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole_to_lambda" {
    role       = "${aws_iam_role.lambda_iam_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

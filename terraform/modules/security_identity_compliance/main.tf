# create_poll

resource "aws_iam_role" "create_poll_lambda_iam_role" {
  name                = "${var.create_poll_lambda_iam_role_name}"
  assume_role_policy  = "${data.aws_iam_policy_document.lambda_trust_policy.json}"
  tags                = var.create_poll_lambda_iam_role_tags
}

resource "aws_iam_role_policy_attachment" "create_poll_lambda_access_ssm_parameters_policy_attach" {
  role                = aws_iam_role.create_poll_lambda_iam_role.name
  policy_arn          = aws_iam_policy.create_poll_lambda_access_ssm_parameters_policy.arn
}

resource "aws_iam_policy" "create_poll_lambda_access_ssm_parameters_policy" {
  name                = "${var.create_poll_lambda_ssm_iam_policy_name}"
  policy              = data.aws_iam_policy_document.create_poll_lambda_access_ssm_parameters_document.json
  tags                = var.create_poll_lambda_ssm_iam_policy_tags
}

data "aws_iam_policy_document" "create_poll_lambda_access_ssm_parameters_document" {
  statement {
    sid               = "AllowLambdaReadSSMParameterAccessBotFredrickDocument"

    effect            = "Allow"

    actions           = [
      "ssm:GetParameters"
    ]

    resources         = [
      "arn:aws:ssm:*:537519792485:parameter/bot_fredrick_email",
      "arn:aws:ssm:*:537519792485:parameter/bot_fredrick_pass",
      "arn:aws:ssm:*:537519792485:parameter/fb_group_chat_thread_id_${var.env}"
    ]
  }
}

# General lambda properties

data "aws_iam_policy_document" "lambda_trust_policy" {
  statement {
    actions           = ["sts:AssumeRole"]
    effect            = "Allow"
    principals {
      type            = "Service"
      identifiers     = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole_to_lambda" {
  role                = "${aws_iam_role.create_poll_lambda_iam_role.name}"
  policy_arn          = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# https://stackoverflow.com/questions/41177965/aws-lambdathe-provided-execution-role-does-not-have-permissions-to-call-describ
resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole_to_lambda" {
  role                = "${aws_iam_role.create_poll_lambda_iam_role.name}"
    policy_arn        = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

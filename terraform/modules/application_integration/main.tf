

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
resource "aws_cloudwatch_event_rule" "event_bridge_rule" {
  name                  = var.event_bridge_name
  #description           = "Trigger for a Lambda every 2 hours"
  tags                  = var.event_bridge_name_tags
  schedule_expression   = var.event_bridge_schedules # "rate(2 hours)" 

}

resource "aws_cloudwatch_event_target" "target_lambda" {
  # "arn:aws:lambda:ap-southeast-2:537519792485:function:bot_fredrick_lambda_dev"
  arn  = var.lambda_function_arn
  rule = aws_cloudwatch_event_rule.event_bridge_rule.name

}

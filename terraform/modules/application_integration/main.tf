resource "aws_cloudwatch_event_rule" "event_bridge_rule" {
  name                  = var.event_bridge_name
  tags                  = var.event_bridge_name_tags
  schedule_expression   = var.event_bridge_schedules
}

resource "aws_cloudwatch_event_target" "target_lambda" {
  arn  = var.lambda_function_arn
  rule = aws_cloudwatch_event_rule.event_bridge_rule.name
}

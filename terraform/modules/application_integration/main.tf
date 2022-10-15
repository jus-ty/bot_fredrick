resource "aws_cloudwatch_event_rule" "create_poll_event_bridge_rule" {
  name                  = var.create_poll_event_bridge_name
  tags                  = var.create_poll_event_bridge_name_tags
  schedule_expression   = var.create_poll_event_bridge_schedule
}

resource "aws_cloudwatch_event_target" "create_poll_lambda_target" {
  arn                   = var.create_poll_lambda_function_arn
  rule                  = aws_cloudwatch_event_rule.create_poll_event_bridge_rule.name
}

# EventBridge ARN
output "create_poll_eventbridge_rule_arn" {
  description = "The create_poll EventBridge Rule ARN"
  value       = aws_cloudwatch_event_rule.create_poll_event_bridge_rule.arn
}

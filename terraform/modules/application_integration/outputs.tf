# EventBridge ARN
output "eventbridge_rule_arns" {
  description = "The EventBridge Rule ARNs"
  value       = aws_cloudwatch_event_rule.event_bridge_rule.arn
}

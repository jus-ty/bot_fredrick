### don't even need this output???
output "eventbridge_rule_arns" {
  description = "The EventBridge Rule ARNs"
  value       = module.eventbridge.eventbridge_rule_arns
}
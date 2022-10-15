
# EventBridge - create_poll
variable "create_poll_event_bridge_name" {
    description = "The create_poll Event bridge name"
    type        = string
}

variable "create_poll_event_bridge_name_tags" {
    description = "The create_poll Event bridge tags"
    type        = map(string)
}

variable "create_poll_event_bridge_schedule" {
    description = "The create_poll Event bridge schedule"
    type        = string
}

# Lambda ARN - create_poll
variable "create_poll_lambda_function_arn" {
    description = "The create_poll Lambda function ARN"
    type        = string
}

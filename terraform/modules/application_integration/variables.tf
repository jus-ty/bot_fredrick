
# EventBridge
variable "event_bridge_name" {
    description = "Event bridge name"
    type        = string
}

variable "event_bridge_name_tags" {
    description = "Event bridge tags"
    type        = map(string)
}

variable "event_bridge_schedules" {
    description = "Event bridge schedule"
    type        = string
}

# Lambda ARN
variable "lambda_function_arn" {
    description = "Lambda function ARN"
    type        = string
}

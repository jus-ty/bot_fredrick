# Lambda - General
variable "lambda_private_subnet_id" {
    description = "Private Subnet ID that lambda operates in"
    type        = string
}

variable "lambda_environment_variable_env" {
    description = "Lambda environment variable used to determine the environment"
    type        = string
}

# Lambda - create_poll
variable "create_poll_lambda_name" {
    description = "Name of the lambda function that creates the poll"
    type        = string
}

variable "create_poll_lambda_tags" {
    description = "Tags for the create_poll lambda"
    type        = map(string)
}

variable "create_poll_lambda_iam_role" {
    description = "IAM role arn for the create_poll lambda function"
    type        = string
}

variable "create_poll_lambda_security_group" {
    description = "ID for the security group of the create_poll lambda function"
    type        = string
}

# EventBridge - create_poll
variable "create_poll_eventbridge_arn" {
    description = "create_poll EventBridge ARN to allow permission to execute Lambda"
    type        = string
}

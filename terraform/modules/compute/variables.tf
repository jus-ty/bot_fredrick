# Lambda
variable "lambda_name" {
    description = "Name of the lambda function"
    type        = string
}

variable "lambda_name_tags" {
    description = "Tags for the lambda"
    type        = map(string)
}

variable "lambda_iam_role" {
    description = "IAM role arn for the lambda function"
    type        = string
}

variable "lambda_security_group" {
    description = "ID for the security group of the lambda function"
    type        = string
}

variable "lambda_subnet_id" {
    description = "Subnet that lambda operates in"
    type        = string
}

variable "lambda_environment_variable_env" {
    description = "Lambda environment variable used to determine the environment"
    type        = string
}
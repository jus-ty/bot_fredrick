# IAM Role
variable "lambda_iam_role_name" {
    description = "Name of the IAM role for the lambda function"
    type        = "string"
}

variable "lambda_iam_role_tags" {
    description = "Tags of the IAM role for the lambda function"
    type        = "string"
}
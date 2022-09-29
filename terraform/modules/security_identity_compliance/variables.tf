# IAM Role
variable "lambda_iam_role_name" {
    description = "Name of the IAM role for the lambda function"
    type        = string
}

variable "lambda_iam_role_tags" {
    description = "Tags of the IAM role for the lambda function"
    type        = map(string)
}

variable "lambda_ssm_iam_policy_name" {
    description = "Name of the IAM Policy document that allows SSM:GetParameters"
    type        = string
}

variable "lambda_ssm_iam_policy_tags" {
    description = "Tag of the IAM Policy document that allows SSM:GetParameters"
    type        = map(string)
}
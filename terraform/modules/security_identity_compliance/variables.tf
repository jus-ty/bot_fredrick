# General
variable "env" {
    description = "Name of the logical environment"
    type        = string
}

# IAM Role - create_poll
variable "create_poll_lambda_iam_role_name" {
    description = "Name of the IAM role for the create_poll lambda function"
    type        = string
}

variable "create_poll_lambda_iam_role_tags" {
    description = "Tags of the IAM role for the create_poll lambda function"
    type        = map(string)
}


# SSM IAM Policy - create_poll
variable "create_poll_lambda_ssm_iam_policy_name" {
    description = "Name of the IAM Policy document that allows SSM:GetParameters for the create_poll lambda"
    type        = string
}

variable "create_poll_lambda_ssm_iam_policy_tags" {
    description = "Tag of the IAM Policy document that allows SSM:GetParameters for the create_poll lambda"
    type        = map(string)
}
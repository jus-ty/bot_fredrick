# SSM Parameter - email
variable "ssm_parameter_account_email_name" {
    description = "The name of the SSM parameter that contains the service account email address"
    type        = string
}

variable "ssm_parameter_account_email_value" {
    description = "The value of the service account email"
    type        = string
}

variable "ssm_parameter_account_email_tags" {
    description = "Tags for the service account email parameter"
    type        = map(string)
}


# SSM Parameter - password
variable "ssm_parameter_account_password_name" {
    description = "The name of the SSM parameter that contains the service account password"
    type        = string
}

variable "ssm_parameter_account_password_value" {
    description = "The value of the service account password"
    type        = string
}

variable "ssm_parameter_account_password_tags" {
    description = "Tags for the service account password parameter"
    type        = map(string)
}


# SSM Parameter - thread_id
variable "ssm_parameter_thread_id_name" {
    description = "The name of the SSM parameter that contains the thread id"
    type        = string
}

variable "ssm_parameter_thread_id_value" {
    description = "The value of the thread id"
    type        = string
}

variable "ssm_parameter_thread_id_tags" {
    description = "Tags for the thread id parameter"
    type        = map(string)
}

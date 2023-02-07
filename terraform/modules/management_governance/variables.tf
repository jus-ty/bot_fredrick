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

# NAT Instance
variable "nat_instance_ec2_arn" {
    description = "EC2 Instance ARN for the NAT Gateway"
    type        = string
}

variable "nat_instance_ec2_id" {
    description = "EC2 Instance ID for the NAT Gateway"
    type        = string
}

# IAM Role for SSM Start/Stop

variable "ssm_automation_iam_role_name" {
    description = "Name for the IAM Role that is assumed by SSM to start and stop the NAT Instance"
    type        = string
}

variable "ssm_automation_iam_role_tags" {
    description = "Tags for the IAM Role that is assumed by SSM to start and stop the NAT Instance"
    type        = map(string)
}

variable "ssm_automation_iam_policy_name" {
    description = "Name for the IAM Policy that is assumed by SSM to start and stop the NAT Instance"
    type        = string
}

variable "ssm_automation_iam_policy_tags" {
    description = "Tags for the IAM Policy that is assumed by SSM to start and stop the NAT Instance"
    type        = map(string)

}

# SSM Maintenance windows - start

variable "ssm_automation_start_maintenance_window_name" {
    description = "Name for the StartInstance maintenance window"
    type        = string
}

variable "ssm_automation_start_maintenance_window_tags" {
    description = "Tags for the StartInstance maintenance window"
    type        = map(string)
}

variable "ssm_automation_start_task_name" {
    description = "Name for the StartInstance task"
    type        = string
}

variable "ssm_automation_start_cron_schedule" {
    description = "The cron schedule of the start instance maintenance window"
    type        = string
}

# SSM Maintenance windows - stop

variable "ssm_automation_stop_maintenance_window_name" {
    description = "Name for the StopInstance maintenance window"
    type        = string
}

variable "ssm_automation_stop_maintenance_window_tags" {
    description = "Tags for the StopInstance maintenance window"
    type        = map(string)  
}

variable "ssm_automation_stop_task_name" {
    description = "Name for the StopInstance task"
    type        = string
}

variable "ssm_automation_stop_cron_schedule" {
    description = "The cron schedule of the stop instance maintenance window"
    type        = string
}
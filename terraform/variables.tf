# General
variable "aws_region" {
    description = "The AWS region to create the resource"
    type        = string
}

variable "logical_environment" {
    description = "The logical environment selected"
    type        = string
}

variable "generic_tags" {
    description = "Generic tags for all resources"
    type        = map(string)
}

variable "create_poll_event_bridge_schedule" {
    description = "Schedule of the event bridge, not in a list/map"
    type        = string
}

variable "git_branch" {
    description = "Name of the branch being used for deployment"
    type        = string
}

variable "account_email" {
    description = "The email of the facebook service account"
    type        = string
}

variable "account_password" {
    description = "The password of the facebook service account"
    type        = string
}

variable "thread_id" {
    description = "The facebook thread ID to interact with"
    type        = string
}

variable "headlesschromium_version" {
    description = "The version of HeadlessChromium"
    type        = string
}

variable "state_bucket_name" {
    description = "The name of the terraform state bucket"
    type        = string
}
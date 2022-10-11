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

variable "event_bridge_schedule" {
    description = "Schedule of the event bridge, not in a list/map"
    type        = string
}

variable "git_branch" {
    description = "Name of the branch being used for deployment"
    type        = string
}

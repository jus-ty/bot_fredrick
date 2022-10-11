# General
aws_region                          = "ap-southeast-2"
logical_environment                 = "dev"
generic_tags    = {
    "Project": "bot_fredrick"
}

event_bridge_schedule               = "cron(0/15 0/1 ? * * *)"              # Every 15 minutes # AWS CRON in UTC timezone, AEST = UTC + 10/11hrs.
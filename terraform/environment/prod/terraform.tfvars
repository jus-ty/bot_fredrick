# General
aws_region                          = "ap-southeast-2"
logical_environment                 = "prod"
generic_tags    = {
    "Project": "bot_fredrick"
}

create_poll_event_bridge_schedule   = "cron(5 0 ? * TUE *)"            # Every Tuesday at 11:05AM. AWS CRON in UTC timezone, AEST = UTC + 10/11hrs.  
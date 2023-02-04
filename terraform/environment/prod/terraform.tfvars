# General
logical_environment                 = "prod"
generic_tags    = {
    "Repo": "bot_fredrick"
}

create_poll_event_bridge_schedule   = "cron(5 0 ? * TUE *)"            # Every Tuesday at 11:05AM. AWS CRON in UTC timezone, AEST = UTC + 10/11hrs.

start_instance_schedule             = "cron(0 0 ? * TUE *)"            # Every Tuesday at 11:00AM. AWS CRON in UTC timezone, AEST = UTC + 10/11hrs.

stop_instance_schedule              = "cron(10 0 ? * TUE *)"           # Every Tuesday at 11:10AM. AWS CRON in UTC timezone, AEST = UTC + 10/11hrs.
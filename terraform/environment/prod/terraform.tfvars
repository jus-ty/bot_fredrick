# General
logical_environment                 = "prod"
generic_tags    = {
    "Repo": "bot_fredrick",
    "Project": "bot_fredrick_prod"
}

create_poll_event_bridge_schedule   = "cron(5 0 ? * TUE *)"            # Every Tuesday at 11:05AM. AWS CRON in UTC timezone, AEST = UTC + 10/11hrs.  
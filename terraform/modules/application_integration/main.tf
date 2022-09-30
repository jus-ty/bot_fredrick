

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
resource "aws_cloudwatch_event_rule" "event_bridge_rule" {
  name                  = "dev-short-schedule2"
  description           = "Trigger for a Lambda every 2 hours"
  schedule_expression   = "rate(2 hours)"

}

resource "aws_cloudwatch_event_target" "target_lambda" {
  arn  = "arn:aws:lambda:ap-southeast-2:537519792485:function:bot_fredrick_lambda_dev"
  rule = aws_cloudwatch_event_rule.event_bridge_rule.name

}


#the main.tf is the very top layer and main functionality
#terraform.tf is where the intermediate variables sit
#variables are the raw hard coded values where this main.tf reads to 
#outputs are used to pass anything to other services

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target



/*
module "application_integration" {
  source = "./modules/application_integration"

  create_bus = false

  rules = {
    crons = {
      description         = "Trigger for a Lambda every 2 hours"
      schedule_expression = "rate(2 hours)"
    }
  }

  targets = {
    crons = [
      {
        name  = "lambda-loves-cron"
        arn   = "arn:aws:lambda:ap-southeast-2:537519792485:function:bot_fredrick_lambda_dev"
        input = jsonencode({ "job" : "cron-by-rate" })
      }
    ]
  }
}

*/

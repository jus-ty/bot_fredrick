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

resource "aws_cloudwatch_event_rule" "event_bridge" {
  name                  = "dev-short-schedule2"
  description           = "Trigger for a Lambda every 2 hours"
  schedule_expression   = "rate(2 hours)"

}
#the main.tf is the very top layer
#terraform.tf is where the intermediate variables sit
#variables are the raw hard coded values

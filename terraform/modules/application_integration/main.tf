

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
resource "aws_cloudwatch_event_rule" "event_bridge_rule" {
  name                  = "dev-short-schedule2"
  description           = "Trigger for a Lambda every 2 hours"
  schedule_expression   = "rate(2 hours)"

}

resource "aws_cloudwatch_event_target" "target_lambda" {
  # "arn:aws:lambda:ap-southeast-2:537519792485:function:bot_fredrick_lambda_dev"
  arn  = var.lambda_arn
  rule = aws_cloudwatch_event_rule.event_bridge_rule.name

}




#the main.tf is the very top layer and main functionality
#variables are the raw hard coded values where this main.tf reads to 
#outputs are used to pass anything to other services

#outside the individual directories:
#terraform.tf is where the intermediate variables sit
#

# terraform/environment/dev/terraform.tfvars
# this is where the raw information is set 
    # eg. lambda_name_tag = {"Name": "bot_fredrick_lambda_dev"}

/*
 (.tfvars)

    lambda_name_single = "bot_fredrick_lambda_dev"
 
 > 
 (variables.tf) 

    variable "lambda_name_single" { ... }
 
 > 
 (terraform.tf) 

    module "compute" {
        source = "./modules/compute"

        # Lambda
        lambda_name = "${var.lambda_name_single}"
    ...}

 > 
 (/compute/variables.tf)
 
    variable "lambda_name" {...}
 
 > 
 (/compute/main.tf)

    resource "aws_lambda_function" "lambda" {
        function_name         = var.lambda_name

*/

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

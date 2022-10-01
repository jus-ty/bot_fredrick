

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
resource "aws_cloudwatch_event_rule" "event_bridge_rule" {
  name                  = var.event_bridge_name
  #description           = "Trigger for a Lambda every 2 hours"
  tags                  = var.event_bridge_name_tags
  schedule_expression   = var.event_bridge_schedules # "rate(2 hours)" 

}

resource "aws_cloudwatch_event_target" "target_lambda" {
  # "arn:aws:lambda:ap-southeast-2:537519792485:function:bot_fredrick_lambda_dev"
  arn  = var.lambda_function_arn
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

    variable "lambda_name_single" {
        description = "Name of the lambda, not in a list/map"
        type        = string
    }
 
 > 
 (terraform.tf) 

    module "compute" {
        source = "./modules/compute"

        # Lambda
        lambda_name = "${var.lambda_name_single}"
    ...}

 > 
 (/compute/variables.tf)
 
    variable "lambda_name" {
        description = "Name of the lambda function"
        type        = string
    }
 
 > 
 (/compute/main.tf)

    resource "aws_lambda_function" "lambda" {
        function_name         = var.lambda_name

*/





## connect output to the main.tf (being used in compute in this example)
/*
(/networking/outputs.tf)
- the value is output generated from the networking module, AWS subnet service

output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}

>
(terraform.tf)

module "compute" {
    source = "./modules/compute"

    lambda_subnet_id = module.networking.private_subnet_id
    ...
    }

>
(compute/variables.tf)

variable "lambda_subnet_id" {...}

>
(/compute/main.tf)

  vpc_config {
    subnet_ids = [var.lambda_subnet_id]
    ...
    }

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

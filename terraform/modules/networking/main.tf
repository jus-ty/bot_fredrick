resource "aws_vpc" "main_vpc" {
  cidr_block    = var.vpc_cidr_block
  tags          = var.vpc_tags
}

# TODO: may need ingress ports open as well? test it
resource "aws_security_group" "lambda_security_group" {
  vpc_id          = aws_vpc.main_vpc.id
  description     = "Security group to be used by the lambda function"
  tags            = var.lambda_security_group_tags

  egress {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description       = "HTTP Access from the lambda to the internet"
  }

  egress {
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description       = "HTTPS Access from the lambda to the internet"
  }

  egress {
    from_port         = 4444
    to_port           = 4445
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description       = "Webdriver from the lambda to the internet (might not be required? test it)"
  }
}

# Need private subnet and routing to internet
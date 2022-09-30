# Lambda ARN
output "lambda_arn" {
    value = aws_subnet.private_subnet.id  #need to have lambda arn here
}
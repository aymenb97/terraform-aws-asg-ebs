
resource "aws_cloudwatch_event_rule" "l_trigger" {
  name        = "aws-"
  description = "Event Bridge"
  event_pattern = jsonencode({
    "source" : ["aws.autoscaling"],
    "detail-type" : ["EC2 Instance-launch Lifecycle Action"]
  })
}
resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.l_trigger.name
  target_id = "SendToLambda"
  arn       = module.lambda_function.lambda_function_arn
}

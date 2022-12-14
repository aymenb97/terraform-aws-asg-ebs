
resource "aws_cloudwatch_event_rule" "l_trigger" {
  name        = "aws-"
  description = "Event Bridge"
  event_pattern = jsonencode({
    "source" : ["aws.autoscaling"],
    "detail-type" : ["EC2 Instance-terminate Lifecycle Action"]
  })
}
resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.l_trigger.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.lambda_asg.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_invoke_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.l_trigger.arn
}



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
  arn       = module.lambda_function.lambda_function_arn
}
output "arn" {
  value = module.lambda_function.lambda_function_arn
}
resource "aws_lambda_permission" "allow_cloudwatch_waktetime_to_invoke" {
  statement_id  = "AllowWaktimeExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.l_trigger.arn
}

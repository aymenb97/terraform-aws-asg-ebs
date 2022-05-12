module "eventbridge" {
  source     = "terraform-aws-modules/eventbridge/aws"
  create_bus = false
  rules = {
    logs = {
      description = ""
      event_pattern = jsonencode({
        "source" : ["aws.autoscaling"],
        "detail-type" : ["EC2 Instance-launch Lifecycle Action"]
      })
    }
  }
  targets = {
    logs = [
      {
        name = "trigger-lambda"
        arn  = module.lambda_function.lambda_function_arn
      }
    ]
  }

}

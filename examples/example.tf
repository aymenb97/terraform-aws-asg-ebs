module "lambda" {
  source      = "../module"
  policy_arns = toset(["arn:aws:iam::974195321489:policy/service-role/AWSLambdaBasicExecutionRole-05c9182c-1b77-43ed-af8d-f0a57b088f4f"])
  key_name    = "test-vpc"
  subnets     = ["subnet-03338579317d8c855"]
}

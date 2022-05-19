module "lambda" {
  source      = "../module"
  policy_arns = toset(["arn:aws:iam::974195321489:policy/allowlambda", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"])
  key_name    = "test-vpc"
  subnets     = ["subnet-03338579317d8c855"]
}
output "name" {
  value = module.lambda.arn
}

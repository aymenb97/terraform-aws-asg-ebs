terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }
}
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-asg-ebs"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}
data "archive_file" "lambda_asg_attach" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/lambda-asg-attach.zip"
}
resource "aws_lambda_function" "lambda_asg" {
  function_name    = var.function_name
  runtime          = "python3.8"
  timeout          = "300"
  handler          = "func.handler"
  filename         = "${path.module}/lambda-asg-attach.zip"
  source_code_hash = data.archive_file.lambda_asg_attach.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn
}
output "arn" {
  value = aws_lambda_function.lambda_asg.arn
}
resource "aws_iam_role_policy_attachment" "_" {
  for_each   = var.policy_arns
  role       = aws_iam_role.lambda_exec.name
  policy_arn = each.key
}



module "lambda_function" {
  source        = "terraform-aws-modules/lambda/aws"
  function_name = var.function_name
  description   = "Lambda function that attaches/detaches volumes on ASG event"
  handler       = "func.lambda_handler"
  runtime       = "python3.8"
  source_path   = "${path.module}/src/func.py"
  lambda_role   = aws_iam_role.lambda_exec.arn
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
resource "aws_iam_role_policy_attachment" "_" {
  role       = aws_iam_role.lambda_exec.name
  for_each   = var.policy_arns
  policy_arn = each.key
}


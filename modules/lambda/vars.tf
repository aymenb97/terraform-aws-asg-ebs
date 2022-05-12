variable "function_name" {
  description = "Name of the Lambda Function"
  type        = string
  default     = "lambda-asg-ebs-attach"

}
variable "policy_arns" {
  description = "Policy ARNs"
  type        = set(string)
}

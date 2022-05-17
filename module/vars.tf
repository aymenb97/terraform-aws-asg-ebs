variable "function_name" {
  description = "Name of the Lambda Function"
  type        = string
  default     = "lambda-asg-ebs-attach"
}
variable "policy_arns" {
  description = "Policy ARNs"
  type        = set(string)
}
variable "min_size" {
  description = "Auto Scaling Group Minimum size"
  type        = number
  default     = 0
}
variable "max_size" {
  description = "Auto Scaling Group Maximum Size"
  type        = number
  default     = 1
}
variable "desired_capacity" {
  description = "Auto Scaling Group Desired Capacity"
  type        = number
  default     = 1
}
variable "heartbeat_time" {
  description = "Heartbeat Time"
  type        = number
  default     = 300
}
variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "asg_name" {
  description = "Name of the ASG"
  type        = string
  default     = "example-asg"

}
variable "az" {
  description = "Availabity Zones List"
  type        = string
  default     = "us-east-1a"
}
variable "subnets" {
  description = "ASG Subnets"
  type        = list(string)
  default     = ["subnet-00eef32c949c26e76"]
}
variable "root_volume_size" {
  description = "Root Volume size in GB"
  type        = number
  default     = 8
}
variable "secondary_volume_size" {
  description = "Secondary Volume Size"
  type        = number
  default     = 8
}
variable "key_name" {
  description = "SSH Key pair name"
  type        = string
}

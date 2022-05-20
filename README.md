# terraform-ebs-asg-attach
This module creates a snapshot from detached volumes from an auto-scaling group in the **Scale-in event**.
## Features :
- Creates an Autoscaling group and attaches two volumes to it (root and secondary).
- Creates a Launch template.
- Creates an `autoscaling:EC2_INSTANCE_TERMINATING` lifecycle hook.
- Creates an Event bridge event pattern to capture Auto scaling events.
- Creates a Lambda function that performs a custom action (Detaches the Volume from the instance, creates a snapshot and then deletes the volume ).
## Usage
Specify the `key_name`, `policy_arns` and the `subnets` in the `examples/example.tf` file.

```shell
$ terraform init 
```

```shell
$ terraform plan 
```

```shell
$ terraform apply 
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.bar](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_cloudwatch_event_rule.l_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.lambda_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment._](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_cloudwatch_to_invoke_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_launch_template.launch_temp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [archive_file.lambda_asg_attach](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | Name of the ASG | `string` | `"example-asg"` | no |
| <a name="input_az"></a> [az](#input\_az) | Availabity Zones List | `string` | `"us-east-1a"` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Auto Scaling Group Desired Capacity | `number` | `1` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of the Lambda Function | `string` | `"lambda-asg-ebs-attach"` | no |
| <a name="input_heartbeat_time"></a> [heartbeat\_time](#input\_heartbeat\_time) | Heartbeat Time | `number` | `300` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance Type | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | SSH Key pair name | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Auto Scaling Group Maximum Size | `number` | `1` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Auto Scaling Group Minimum size | `number` | `0` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | Policy ARNs | `set(string)` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Root Volume size in GB | `number` | `8` | no |
| <a name="input_secondary_volume_size"></a> [secondary\_volume\_size](#input\_secondary\_volume\_size) | Secondary Volume Size | `number` | `8` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List Subnets | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the lambda function |
<!-- END_TF_DOCS -->
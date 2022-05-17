data "aws_ami" "_" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
module "auto_scaling_group" {
  source              = "terraform-aws-modules/autoscaling/aws"
  vpc_zone_identifier = var.subnets
  placement = {
    availability_zone = var.az
  }
  name              = var.asg_name
  min_size          = var.min_size
  max_size          = var.max_size
  desired_capacity  = var.desired_capacity
  key_name          = var.key_name
  health_check_type = "EC2"
  initial_lifecycle_hooks = [

    {
      name                 = "detach-ebs"
      default_result       = "ABANDON"
      heartbeat_time       = var.heartbeat_time
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"

    }
  ]
  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true
  security_groups             = ["sg-02ea136ed31d4087d"]
  use_lt                      = true
  create_lt                   = true

  # image_id          = data.aws_ami._.image_id
  image_id          = "ami-0022f774911c1d690"
  instance_type     = var.instance_type
  ebs_optimized     = true
  enable_monitoring = true

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.root_volume_size
        volume_type           = "gp2"
      }
      }, {
      device_name = "/dev/sda1"
      no_device   = 1
      ebs = {
        delete_on_termination = false
        encrypted             = true
        volume_size           = var.secondary_volume_size
        volume_type           = "gp2"
      }
    }
  ]
}

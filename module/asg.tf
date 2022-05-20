resource "aws_autoscaling_group" "bar" {
  name                      = "foobar3-terraform-test"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.subnets
  launch_template {
    id      = aws_launch_template.launch_temp.id
    version = "$Latest"
  }
  initial_lifecycle_hook {
    name                 = "foobar"
    default_result       = "ABANDON"
    heartbeat_timeout    = var.heartbeat_time
    lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
  }
  force_delete = true
}



resource "aws_launch_template" "launch_temp" {
  image_id      = "ami-0022f774911c1d690"
  instance_type = var.instance_type
  block_device_mappings {
    device_name = "/dev/sdb"
    ebs {
      delete_on_termination = false
      encrypted             = true
      volume_size           = var.root_volume_size
      volume_type           = "gp2"
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      env = "prod"
    }
  }
}

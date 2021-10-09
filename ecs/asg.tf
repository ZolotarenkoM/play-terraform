resource "aws_autoscaling_group" "my_asg" {
  name_prefix          = "asg-ecs-${aws_launch_configuration.ecs_launch_configuration.name}"
  launch_configuration = aws_launch_configuration.ecs_launch_configuration.name
  termination_policies = ["OldestInstance"]
  min_size             = var.ecs_nodes_min
  max_size             = var.ecs_nodes_max
  desired_capacity     = var.ecs_nodes_desired
  health_check_type    = "EC2"
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids
  dynamic "tag" {
    for_each = {
      Name  = "ASG-ecs"
      Owner = "M.Zolotarenko"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_launch_configuration" "ecs_launch_configuration" {
  name_prefix                 = "mzol-ecs-lc-"
  image_id                    = data.aws_ami.ecs_ami.image_id
  instance_type               = var.ecs_instance_type
  security_groups             = [aws_security_group.http.id]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${var.ecs_cluster_name} > /etc/ecs/ecs.config"
  key_name                    = "n_virginia_mzol_free"
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.ecs_ec2_role.id
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_security_group.http]
}

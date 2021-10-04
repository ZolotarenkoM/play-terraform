resource "aws_autoscaling_group" "my_asg" {
  name_prefix          = "asg-${aws_launch_configuration.my_launch_configuration.name}"
  launch_configuration = aws_launch_configuration.my_launch_configuration.name
  min_size             = 2
  max_size             = 2
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids
  target_group_arns    = [aws_lb_target_group.target_group_mzol.arn]
  health_check_type    = "ELB"
  dynamic "tag" {
    for_each = {
      Name  = "ASG-mzol"
      Owner = "M.Zolotarenko"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  depends_on = [aws_lb_target_group.target_group_mzol]
}

resource "aws_launch_configuration" "my_launch_configuration" {
  name_prefix     = "mzol-lc-"
  image_id        = data.aws_ami.latest_amazon2_ami.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ssh_http.id]
  user_data       = file("bootstrap.sh")
  key_name        = "n_virginia_mzol_free"
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_security_group.ssh_http]
}

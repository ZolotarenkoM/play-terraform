resource "aws_autoscaling_group" "my_asg" {
  name                 = "asg-mzol"
  launch_configuration = aws_launch_configuration.my_launch_configuration.name
  min_size             = 2
  max_size             = 2
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids
  target_group_arns    = [aws_lb_target_group.target_group_mzol.arn]
  health_check_type    = "ELB"
  tag {
    key                 = "Name"
    value               = "ASG-mzol"
    propagate_at_launch = false
  }
  depends_on = [aws_lb_target_group.target_group_mzol]
}

resource "aws_launch_configuration" "my_launch_configuration" {
  image_id        = "ami-087c17d1fe0178315"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ssh_http.id]
  user_data       = file("bootstrap.sh")
  key_name        = "n_virginia_mzol_free"
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [aws_security_group.ssh_http]
}

resource "aws_elb" "elb-mzol" {
  name               = "elb-mzol"
  availability_zones = data.aws_availability_zones.default.names
  //  load_balancer_type = "application"

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  security_groups = [aws_security_group.ssh_http.id]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/"
    interval            = 10
  }
  instances                 = data.aws_instances.default.ids
  cross_zone_load_balancing = true
  // idle_timeout              = 400
  //  connection_draining         = true
  //  connection_draining_timeout = 400

  depends_on = [aws_autoscaling_group.my_asg]

  tags = {
    Name = "mzol-terraform-elb"
  }
}

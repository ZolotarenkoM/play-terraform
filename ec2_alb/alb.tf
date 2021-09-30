resource "aws_lb" "alb_mzol" {
  name                             = "alb-mzol"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.ssh_http.id]
  subnets                          = data.aws_subnet_ids.default.ids
  enable_cross_zone_load_balancing = true
  idle_timeout                     = 120

  depends_on = [aws_security_group.ssh_http, aws_lb_target_group.target_group_mzol]

  tags = {
    Name = "mzol-terraform-alb"
  }
}

resource "aws_lb_target_group" "target_group_mzol" {
  name     = "alb-target-group-mzol"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
  }
  depends_on = [aws_security_group.ssh_http]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb_mzol.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "http_listener_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_mzol.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

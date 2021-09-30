data "aws_ami" "ecs_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

module "app_ecs_cluster" {
  source = "git::ssh://git@github.com/trussworks/terraform-aws-ecs-cluster.git?ref=v3.01"

  name        = "ecs-mzol"
  environment = "test"

  image_id           = data.aws_ami.ecs_ami.image_id
  instance_type      = "t2.micro"
  security_group_ids = [aws_security_group.http.id]

  vpc_id           = data.aws_vpc.default.id
  subnet_ids       = data.aws_subnet_ids.default.ids
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
}


resource "aws_ecs_task_definition" "mzol_app1" {
  family                = "mzol_app1"
  container_definitions = file("task-definitions-http.json")
}

resource "aws_ecs_service" "mzol_app1" {
  name = "mzol_app1"
  //cluster         = data.app_ecs_cluster.id
  task_definition = aws_ecs_task_definition.mzol_app1.arn
  //    iam_role = "${aws_iam_role.ecs_service_role.arn}"
  desired_count = 1
  //    depends_on = ["aws_iam_role_policy.ecs_service_role_policy"]
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  load_balancer {
    elb_name       = aws_lb.alb_mzol.id
    container_name = "mzol_app1-runner"
    container_port = 80
  }
}

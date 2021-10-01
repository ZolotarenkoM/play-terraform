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
  name                               = "mzol_app1"
  cluster                            = module.app_ecs_cluster.ecs_cluster_arn
  task_definition                    = aws_ecs_task_definition.mzol_app1.arn
  iam_role                           = aws_iam_role.ecs_service_role.arn
  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group_mzol.arn
    container_name   = "mzol_app1"
    container_port   = 80
  }
  depends_on = [aws_iam_role.ecs_service_role]
}

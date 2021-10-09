resource "aws_ecs_cluster" "app_ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "mzol_app" {
  family                = "mzol_app"
  container_definitions = file("task-definitions-http.json")
  tags                  = var.tags
}

resource "aws_ecs_service" "mzol_app" {
  name                               = "mzol_app"
  cluster                            = aws_ecs_cluster.app_ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.mzol_app.arn
  iam_role                           = aws_iam_role.ecs_service_role.arn
  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group_mzol.arn
    container_name   = "mzol_app"
    container_port   = 80
  }
  depends_on = [aws_iam_role.ecs_service_role]
  tags       = var.tags
}

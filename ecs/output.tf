output "aws_sg_description" {
  value = aws_security_group.http.description
}

output "aws_vpc_id" {
  value = data.aws_vpc.default.id
}

output "aws_vpc_cidr" {
  value = data.aws_vpc.default.cidr_block
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.default.names
}

output "aws_subnet_ids" {
  value = data.aws_subnet_ids.default.ids
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.default.account_id
}

output "aws_load_balancer_dns_name" {
  value = aws_lb.alb_mzol.dns_name
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.app_ecs_cluster.arn
}

output "ecs-service-role-arn" {
  value = aws_iam_role.ecs_service_role.arn
}

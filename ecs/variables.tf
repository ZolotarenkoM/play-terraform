variable "region" {
  default = "us-east-1"
}

variable "ecs_instance_type" {
  default = "t2.micro"
}

variable "ecs_cluster_name" {
  default     = "ecs-mzol"
  description = "The name of the Amazon ECS cluster."
}

variable "ecs_nodes_min" {
  default     = "1"
  description = "Minimum autoscale (number of EC2)"
}

variable "ecs_nodes_max" {
  default     = "1"
  description = "Maximum autoscale (number of EC2)"
}

variable "ecs_nodes_desired" {
  default     = "1"
  description = "Desired autoscale (number of EC2)"
}

variable "load_balancer_name" {
  default     = "alb-mzol"
  description = "The name of the Amazon ALB)"
}

variable "tags" {
  default = {
    owner = "M.Zolotarenko"
    env   = "test"
    desc  = "Create by terraform"
  }
  description = "Resource tags"
}

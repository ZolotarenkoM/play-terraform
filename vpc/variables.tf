variable "region" {
  default = "us-east-2"
}

variable "env" {
  default = "test"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.10.0/24"
  ]
}

locals {
  tags = {
    owner       = "M.Zolotarenko"
    env         = var.env
    desc        = "Create by terraform"
    description = "Resource tags"
  }
}

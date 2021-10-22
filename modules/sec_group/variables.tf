variable "name" {
  default = "default_security_group"
}

variable "description" {
  default = "Default description"
}

variable "vpc_id" {
  type = string
  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "The vpc_id value must be a valid VPC id, starting with \"vpc-\"."
  }
}

variable "ports" {}

variable "ingress_cidr_blocks" {
  default = "0.0.0.0/0"
}

variable "egress_cidr_blocks" {
  default = "0.0.0.0/0"
}

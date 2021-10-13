provider "aws" {
  region = var.region
}

data "aws_ami" "latest_amazon2_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

variable "region" {
  default = "us-east-1"
}

variable "env" {
  default = "dev"
}

variable "ec2_size" {
  default = {
    dev  = "t2.micro"
    prod = "t2.small"
  }
}

variable "ec2_count" {
  default = {
    dev  = 1
    prod = 2
  }
}

resource "aws_instance" "test_ec2" {
  ami           = data.aws_ami.latest_amazon2_ami.id
  instance_type = lookup(var.ec2_size, var.env)
  count         = lookup(var.ec2_count, var.env)
  tags = {
    Name = "${var.env}-instance-${count.index + 1}"
  }
}

output "env" {
  value = var.env
}

output "ec2_count" {
  value = length(aws_instance.test_ec2)
}

output "ec2_type" {
  value = aws_instance.test_ec2[*].instance_type
}

output "ec2_info" {
  value = [
    for ec2 in aws_instance.test_ec2 :
    "ami: ${ec2.ami}, type: ${ec2.instance_type}"
  ]
}

output "ec2_info_map" {
  value = {
    for ec2 in aws_instance.test_ec2 :
    ec2.id => ec2.instance_type
  }
}

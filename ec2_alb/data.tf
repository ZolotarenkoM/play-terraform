data "aws_vpc" "default" {}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_availability_zones" "default" {}

data "aws_caller_identity" "default" {}

data "aws_instances" "default" {
  //instance_tags = {
  //  Name = "ASG-mzol"
  //}
  filter {
    name   = "instance.group-id"
    values = [aws_security_group.ssh_http.id]
  }
  instance_state_names = ["running", "stopped"]
}

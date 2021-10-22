data "aws_ami" "latest_amazon2_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_availability_zones" "available" {}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = aws_vpc.main.id
}

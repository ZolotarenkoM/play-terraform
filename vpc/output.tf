output "security_group_id" {
  value = aws_security_group.ssh_http.id
}

output "aws_vpc_id" {
  value = aws_vpc.main.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.main.id
}

output "aws_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "aws_instance_public_ip" {
  value = aws_instance.test_ec2.public_ip
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "aws_instance_subnet_id" {
  value = aws_instance.test_ec2.subnet_id
}

output "aws_instance_subnet_cidr" {
  value = aws_subnet.public_subnets[1].cidr_block
}

resource "aws_instance" "test_ec2" {
  ami           = data.aws_ami.latest_amazon2_ami.id
  instance_type = "t2.micro"
  //count                  = 1
  subnet_id              = aws_subnet.public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.ssh_http.id]
  user_data              = file("bootstrap.sh")
  tags                   = merge(local.tags, { Name = "${var.env}-ec2" })
  depends_on             = [aws_security_group.ssh_http]
}

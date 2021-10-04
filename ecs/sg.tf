resource "aws_security_group" "http" {
  name        = "http"
  description = "Allow http inbound traffic"

  dynamic "ingress" {
    for_each = ["80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //  depends_on = [aws_security_group.https]

  tags = var.tags
}
